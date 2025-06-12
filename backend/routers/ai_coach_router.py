from typing import List, Dict

from fastapi import APIRouter, Depends, HTTPException, status
from pydantic import BaseModel, Field

from ..dependencies import get_current_active_user
from .. import models, crud
from ..services.ai_coach_service import get_ai_coach_response

router = APIRouter(
    prefix="/api/v1/ai-coach",
    tags=["AI Coach"],
)

MAX_TURNS = 10  # user+assistant pairs
MAX_MSG_CHARS = 50000

class ChatMessage(BaseModel):
    role: str = Field(..., pattern="^(user|assistant)$")
    content: str = Field(..., max_length=MAX_MSG_CHARS)

class ChatRequest(BaseModel):
    messages: List[ChatMessage] = Field(..., max_items=MAX_TURNS * 2)

class ChatResponse(BaseModel):
    assistant_response: str

@router.post("/", response_model=ChatResponse)
async def chat_with_ai(
    payload: ChatRequest,
    current_user: models.User = Depends(get_current_active_user),
):
    """Return an AI-generated reply based on the conversation so far plus user context."""
    # Enforce turn limit (client should also trim but server double-checks)
    if len(payload.messages) > MAX_TURNS * 2:
        payload.messages = payload.messages[-MAX_TURNS * 2 :]

    # Build dynamic user context
    context_fragments = []
    context_fragments.append(f"User name: {current_user.name}")
    if current_user.age:
        context_fragments.append(f"Age: {current_user.age}")
    if current_user.gender:
        context_fragments.append(f"Gender: {current_user.gender}")
    if current_user.fitness_goals:
        context_fragments.append(f"Goals: {', '.join(current_user.fitness_goals)}")

    # Totals from activity logs
    running_km = sum(a.value for a in current_user.tracked_activities if a.activity_type == "running")
    steps = sum(a.value for a in current_user.tracked_activities if a.activity_type == "steps")
    gym_minutes = sum(a.value for a in current_user.tracked_activities if a.activity_type == "gym_time")
    context_fragments.append(f"Lifetime running km: {running_km:.1f}")
    context_fragments.append(f"Lifetime steps: {int(steps)}")
    context_fragments.append(f"Lifetime gym minutes: {int(gym_minutes)}")

    system_prompt = (
        "You are an AI personal coach specialising in sports, nutrition and gym training. "
        "When the user's last message is written mainly in Arabic characters, respond in Arabic; otherwise respond in English. "
        "Ask the user at most 2 clarifying questions before giving advice; Only if the user's message is sports related. "
        "Always keep answers clear and concise (≤50 words) and feel free to use basic Markdown (lists, **bold**, etc.) to structure the reply. "
        "If advice could be unsafe, ask clarifying questions first.\n\n" + "\n".join(context_fragments)
    )

    messages: List[Dict[str, str]] = [
        {"role": "system", "content": system_prompt}
    ] + [m.model_dump() for m in payload.messages][-MAX_TURNS * 2 :]

    assistant_reply = await get_ai_coach_response(messages=messages)
    return ChatResponse(assistant_response=assistant_reply) 