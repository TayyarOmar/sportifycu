from typing import List
from .models import ActivityLog # Assuming ActivityLog is defined in models.py

def calculate_activity_score(activities: List[ActivityLog]) -> float:
    """
    Calculates a composite score based on a list of activities.
    This is an example scoring logic. Product requirements should define actual weights and rules.
    """
    score = 0.0
    
    # Define points per unit for each activity type
    # These are example values and can be tuned
    points_per_km_running = 10.0
    points_per_100_steps = 1.0  # So 1 point per 100 steps
    points_per_minute_gym = 0.2 # So 1 point per 5 minutes of gym time

    for activity in activities:
        if activity.activity_type == "running" and activity.unit == "km":
            score += activity.value * points_per_km_running
        elif activity.activity_type == "steps" and activity.unit == "steps":
            score += (activity.value / 100) * points_per_100_steps 
        elif activity.activity_type == "gym_time" and activity.unit == "minutes":
            score += activity.value * points_per_minute_gym
        # Could add other activity types or more complex rules here
        # e.g., bonus points for consistency, variety, etc.

    return round(score, 2)

# Example: Generate a simple achievement based on score (conceptual)
# This would typically live in a more complex achievement service/logic area.
# def check_and_grant_achievements(user: 'models.User', current_score: float) -> List[str]:
#     newly_granted_achievements = []
#     if current_score >= 100 and "Reached 100 Points!" not in user.achievements:
#         newly_granted_achievements.append("Reached 100 Points!")
#     if current_score >= 500 and "Reached 500 Points!" not in user.achievements:
#         newly_granted_achievements.append("Reached 500 Points!")
#     # Add more achievement checks here
#     return newly_granted_achievements

# Any other utility functions can be added here.
# For example, helper for parsing age ranges, etc. 