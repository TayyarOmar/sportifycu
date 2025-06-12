from __future__ import annotations

import httpx
from typing import List, Dict
from ..config import settings

DEEPSEEK_API_URL = "https://api.deepseek.com/v1/chat/completions"  # Example; adjust if different

async def get_ai_coach_response(messages: List[Dict[str, str]]) -> str:
    """Send chat messages to DeepSeek and return the assistant's reply.

    Args:
        messages: OpenAI-compatible chat messages, each with keys ``role`` and ``content``.

    Returns:
        Assistant reply text. Falls back to a generic error string if request fails.
    """
    headers = {
        "Authorization": f"Bearer {settings.DEEPSEEK_API_KEY}",
        "Content-Type": "application/json",
    }

    payload = {
        "model": "deepseek-chat",  # DeepSeek supports the OpenAI schema; change if required
        "messages": messages,
        "temperature": 0.6,
        "max_tokens": 1024,
    }

    try:
        async with httpx.AsyncClient(timeout=30) as client:
            resp = await client.post(DEEPSEEK_API_URL, json=payload, headers=headers)
            resp.raise_for_status()
            data = resp.json()
            return data["choices"][0]["message"]["content"].strip()
    except Exception as exc:
        # Log the error server-side; return user-friendly message
        print(f"AI coach request failed: {exc}")
        return "Sorry, I couldn't process that right now. Please try again later." 