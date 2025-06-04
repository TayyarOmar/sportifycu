"""
Add User Script for Sportify Backend Development

This script adds a comprehensive user to the database with all possible fields populated.
Use this during development to create test users with realistic data.

USAGE:
    python -m backend.database_data.add_user

WHAT THIS SCRIPT DOES:
- Creates a user with ALL possible fields from the User model
- Adds sample activity logs (running, steps, gym time)
- Sets up 2FA key and enables 2FA
- Adds sample achievements
- Sets notification preferences
- Adds sample bookings and favorites

FIELD EXPLANATIONS:
- user_id: str - Auto-generated UUID, don't modify
- name: str - Full name of the user
- email: EmailStr - Valid email address (must be unique)
- hashed_password: str - Bcrypt hashed password (use plain password, script will hash it)
- gender: Optional[str] - "Male", "Female", "Other", or None
- age: Optional[int] - Age in years (18-100 typical range)
- fitness_goals: List[str] - Multiple goals like ["Weight Loss", "Muscle Gain", "Endurance"]
- two_fa_key: str - TOTP secret key (auto-generated)
- is_2fa_enabled: bool - Whether 2FA is enabled
- tracked_activities: List[ActivityLog] - List of activity entries
- favourites: List[str] - List of gym IDs (will be empty initially, add after gyms exist)
- achievements: List[str] - List of achievement names
- notification_setting: bool - Whether user wants notifications
- bookings: List[str] - List of team IDs user is booked into

ACTIVITY LOG FIELDS:
- date: date - Date of activity (YYYY-MM-DD format)
- activity_type: str - "running", "steps", "gym_time"
- value: float - Numeric value (distance in km, step count, minutes)
- unit: str - "km", "steps", "minutes"

DO NOT:
- Use duplicate emails (will cause database constraint error)
- Use invalid email formats
- Set user_id manually (auto-generated)
- Add non-existent gym_ids to favourites
- Add non-existent team_ids to bookings
"""

import sys
import os
from datetime import date

# Add the parent directory to the path to import backend modules
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from backend.models import User, ActivityLog
from backend.schemas import UserCreate
from backend import crud, auth

def create_comprehensive_user():
    """
    Creates a comprehensive user with all possible fields populated.
    This demonstrates every field that can be set on a User model.
    """
    
    # Basic user information
    user_data = UserCreate(
        name="John Doe",                    # str: Full name
        email="john.doe@example.com",       # EmailStr: Must be unique and valid
        password="SecurePassword123!",      # str: Plain password (will be hashed)
        gender="Male",                      # Optional[str]: "Male", "Female", "Other", or None
        age=28                              # Optional[int]: Age in years
    )
    
    print("Creating user with basic information...")
    print(f"Name: {user_data.name}")
    print(f"Email: {user_data.email}")
    print(f"Gender: {user_data.gender}")
    print(f"Age: {user_data.age}")
    
    # Create the user in database
    try:
        created_user = crud.create_user_db(user_data=user_data)
        if not created_user:
            print("❌ Failed to create user - email might already exist")
            return None
        print(f"✅ User created with ID: {created_user.user_id}")
    except Exception as e:
        print(f"❌ Error creating user: {e}")
        return None
    
    # Generate and set 2FA key
    print("\nSetting up 2FA...")
    two_fa_key = auth.generate_2fa_secret_key()
    print(f"Generated 2FA key: {two_fa_key}")
    
    # Update user with 2FA and additional fields
    update_data = {
        "two_fa_key": two_fa_key,
        "is_2fa_enabled": True,
        
        # Fitness goals - List[str]: Can have multiple goals
        "fitness_goals": [
            "Weight Loss",          # Common goal
            "Muscle Gain",          # Common goal
            "Endurance Training",   # Common goal
            "Flexibility",          # Less common but valid
            "Stress Relief"         # Mental health goal
        ],
        
        # Achievements - List[str]: Achievement names or IDs
        "achievements": [
            "First Workout",        # Beginner achievement
            "10K Steps",           # Daily step goal
            "5K Runner",           # Running milestone
            "Gym Regular",         # Consistency achievement
            "Early Bird"           # Time-based achievement
        ],
        
        # Notification setting - bool: Whether user wants notifications
        "notification_setting": True,  # Most users want notifications
        
        # Favourites and bookings will be empty initially
        # These should be populated after gyms and teams exist
        "favourites": [],       # List[str]: Gym IDs (empty for now)
        "bookings": []          # List[str]: Team IDs (empty for now)
    }
    
    print("Updating user with additional fields...")
    updated_user = crud.update_user_db(user_id=created_user.user_id, user_update_data=update_data)
    if not updated_user:
        print("❌ Failed to update user with additional fields")
        return None
    
    print("✅ User updated with 2FA and additional fields")
    
    # Add comprehensive activity logs
    print("\nAdding activity logs...")
    
    # Sample activity logs covering different types and dates
    activity_logs = [
        # Running activities - value in kilometers
        ActivityLog(
            date=date(2024, 1, 15),
            activity_type="running",
            value=5.2,              # 5.2 km run
            unit="km"
        ),
        ActivityLog(
            date=date(2024, 1, 17),
            activity_type="running",
            value=3.8,              # 3.8 km run
            unit="km"
        ),
        ActivityLog(
            date=date(2024, 1, 20),
            activity_type="running",
            value=7.5,              # 7.5 km long run
            unit="km"
        ),
        
        # Step count activities - value in steps
        ActivityLog(
            date=date(2024, 1, 15),
            activity_type="steps",
            value=12500,            # 12,500 steps
            unit="steps"
        ),
        ActivityLog(
            date=date(2024, 1, 16),
            activity_type="steps",
            value=8900,             # 8,900 steps
            unit="steps"
        ),
        ActivityLog(
            date=date(2024, 1, 17),
            activity_type="steps",
            value=15200,            # 15,200 steps (very active day)
            unit="steps"
        ),
        ActivityLog(
            date=date(2024, 1, 18),
            activity_type="steps",
            value=6800,             # 6,800 steps (less active)
            unit="steps"
        ),
        
        # Gym time activities - value in minutes
        ActivityLog(
            date=date(2024, 1, 16),
            activity_type="gym_time",
            value=75,               # 75 minutes gym session
            unit="minutes"
        ),
        ActivityLog(
            date=date(2024, 1, 18),
            activity_type="gym_time",
            value=60,               # 60 minutes gym session
            unit="minutes"
        ),
        ActivityLog(
            date=date(2024, 1, 19),
            activity_type="gym_time",
            value=90,               # 90 minutes long session
            unit="minutes"
        ),
        ActivityLog(
            date=date(2024, 1, 21),
            activity_type="gym_time",
            value=45,               # 45 minutes quick session
            unit="minutes"
        )
    ]
    
    # Add each activity log
    for i, activity_log in enumerate(activity_logs, 1):
        try:
            result = crud.add_activity_log_db(user_id=updated_user.user_id, activity_log=activity_log)
            if result:
                print(f"✅ Added activity log {i}/{len(activity_logs)}: {activity_log.activity_type} - {activity_log.value} {activity_log.unit}")
            else:
                print(f"❌ Failed to add activity log {i}")
        except Exception as e:
            print(f"❌ Error adding activity log {i}: {e}")
    
    # Calculate and display user's score
    print("\nCalculating user activity score...")
    from backend.utils import calculate_activity_score
    final_user = crud.get_user_by_id(updated_user.user_id)
    if final_user:
        score = calculate_activity_score(final_user.tracked_activities)
        print(f"📊 User's calculated activity score: {score}")
    
    print("\n" + "="*60)
    print("USER CREATION SUMMARY")
    print("="*60)
    print(f"User ID: {updated_user.user_id}")
    print(f"Name: {updated_user.name}")
    print(f"Email: {updated_user.email}")
    print(f"Age: {updated_user.age}")
    print(f"Gender: {updated_user.gender}")
    print(f"2FA Enabled: {updated_user.is_2fa_enabled}")
    print(f"Fitness Goals: {', '.join(updated_user.fitness_goals)}")
    print(f"Achievements: {', '.join(updated_user.achievements)}")
    print(f"Notifications: {'Enabled' if updated_user.notification_setting else 'Disabled'}")
    print(f"Activity Logs: {len(updated_user.tracked_activities)} entries")
    print(f"Activity Score: {score if 'score' in locals() else 'N/A'}")
    print("="*60)
    
    print("\n💡 NEXT STEPS:")
    print("1. Create gyms using add_gym.py")
    print("2. Create activity teams using add_group_activity_team.py")
    print("3. Manually add gym IDs to user's favourites if needed")
    print("4. Manually add team IDs to user's bookings if needed")
    
    return updated_user

if __name__ == "__main__":
    print("🏃‍♂️ SPORTIFY USER CREATION SCRIPT")
    print("="*60)
    print("This script creates a comprehensive user with all possible fields.")
    print("Perfect for development and testing purposes.")
    print("="*60)
    
    user = create_comprehensive_user()
    
    if user:
        print("\n✅ User creation completed successfully!")
        print("You can now use this user for testing the application.")
    else:
        print("\n❌ User creation failed!")
        print("Check the error messages above for details.") 