"""
Add Group Activity Team Script for Sportify Backend Development

This script adds comprehensive group activity teams to the database with all possible fields populated.
Use this during development to create test teams with realistic data.

USAGE:
    python -m backend.database_data.add_group_activity_team

WHAT THIS SCRIPT DOES:
- Creates multiple activity teams with ALL possible fields from the GroupActivityTeam model
- Sets up different activity types and difficulty levels
- Configures team capacity and booking systems
- Sets various pricing models
- Creates teams for different demographics and interests

FIELD EXPLANATIONS:
- team_id: str - Auto-generated UUID, don't modify
- lister_id: str - User ID of the person who created the team
- name: str - Name of the activity team/group
- description: str - Detailed description of the team and activities
- category: str - Type of activity (e.g., "Running", "Yoga", "CrossFit")
- location: str - Where the team meets
- date_and_time: datetime - When the team meets (specific datetime)
- age_range: Optional[str] - Age range like "18-25", "Any"
- contact_information: str - How to contact the organizer
- players_needed: int - Maximum number of participants needed
- current_players_count: int - Current number of enrolled participants (starts at 0)
- players_enrolled: List[str] - List of user IDs who joined (empty initially)
- status: str - "active", "filled", "cancelled"
- photo_base64: Optional[str] - Base64 encoded photo data

ACTIVITY TYPES:
- Cardio: "Running", "Cycling", "Swimming", "HIIT"
- Strength: "CrossFit", "Weightlifting", "Bodyweight", "Powerlifting"
- Mind-Body: "Yoga", "Pilates", "Meditation", "Tai Chi"
- Sports: "Basketball", "Soccer", "Tennis", "Volleyball"
- Dance: "Zumba", "Hip Hop", "Ballroom", "Contemporary"
- Outdoor: "Hiking", "Rock Climbing", "Kayaking", "Cycling"
- Martial Arts: "Karate", "Boxing", "Kickboxing", "Jiu-Jitsu"

DIFFICULTY LEVELS:
- "Beginner" - New to the activity
- "Intermediate" - Some experience required
- "Advanced" - High skill level required
- "All Levels" - Suitable for everyone

REQUIREMENTS EXAMPLES:
- Equipment: "Yoga Mat", "Water Bottle", "Towel", "Boxing Gloves"
- Clothing: "Athletic Wear", "Swimming Suit", "Proper Footwear"
- Experience: "Basic Fitness Level", "Swimming Ability", "No Injuries"
- Other: "Signed Waiver", "Medical Clearance", "Own Equipment"

PHOTO DATA:
- photo_base64: Base64 encoded image data (PNG, JPEG, etc.)
- Use small images for demo purposes (large images increase database size)
- Format: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAAB..."
- Can be None if no photo is provided

DO NOT:
- Use duplicate team names for same activity type
- Set team_id manually (auto-generated)
- Set current_players_count higher than players_needed
- Set negative capacity values
- Add non-existent user_ids to players_enrolled initially
- Use extremely large base64 images (impacts database performance)
"""

import sys
import os
import base64

# Add the parent directory to the path to import backend modules
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from backend.models import GroupActivityTeam
from backend import crud
from datetime import datetime

# Sample base64 encoded images (small 1x1 pixel images for demo purposes)
SAMPLE_IMAGES = {
    "running": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNkYPhfDwAChwGA60e6kgAAAABJRU5ErkJggg==",  # Red pixel
    "crossfit": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==",  # Green pixel
    "yoga": "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mP8/5+hHgAHggJ/PchI7wAAAABJRU5ErkJggg=="     # Blue pixel
}

def create_comprehensive_activity_teams():
    """
    Creates multiple comprehensive activity teams with all possible fields populated.
    This demonstrates every field that can be set on a GroupActivityTeam model.
    """
    
    # Team 1: Beginner Running Group
    print("Creating Team 1: Beginner Running Group...")
    team1 = GroupActivityTeam(
        lister_id="system-admin",                                 # str: Creator user ID (using system for demo)
        name="Morning Joggers Club",                              # str: Team name
        description="A friendly running group for beginners who want to start their fitness journey. We focus on building endurance gradually with a supportive community atmosphere. Perfect for those who have never run before or are getting back into fitness.",  # str: Detailed description
        category="Running",                                       # str: Activity category
        location="Central Park Main Loop",                        # str: Where team meets
        date_and_time=datetime(2024, 2, 5, 7, 0),               # datetime: Next Monday 7:00 AM
        age_range="18-65",                                        # Optional[str]: Age range
        contact_information="sarah.johnson@email.com or call (555) 123-4567",  # str: Contact info
        players_needed=15,                                        # int: Maximum participants
        current_players_count=0,                                  # int: Current participants (starts at 0)
        players_enrolled=[],                                      # List[str]: User IDs (empty initially)
        status="active",                                          # str: Team status
        photo_base64=SAMPLE_IMAGES["running"]                     # Optional[str]: Base64 encoded photo
    )
    
    # Team 2: Advanced CrossFit Class
    print("Creating Team 2: Advanced CrossFit Class...")
    team2 = GroupActivityTeam(
        lister_id="system-admin",
        name="Elite CrossFit Warriors",
        description="High-intensity CrossFit training for experienced athletes. This class focuses on Olympic lifts, metabolic conditioning, and advanced movement patterns. Participants should have at least 6 months of CrossFit experience.",
        category="CrossFit",
        location="Iron Fist Combat Academy - CrossFit Area",
        date_and_time=datetime(2024, 2, 6, 18, 30),              # Tuesday 6:30 PM
        age_range="21-45",
        contact_information="mike.rodriguez@ironfist.com or (555) 987-6543",
        players_needed=12,
        current_players_count=0,
        players_enrolled=[],
        status="active",
        photo_base64=SAMPLE_IMAGES["crossfit"]
    )
    
    # Team 3: All-Levels Yoga Class
    print("Creating Team 3: All-Levels Yoga Class...")
    team3 = GroupActivityTeam(
        lister_id="system-admin",
        name="Sunset Yoga Flow",
        description="A peaceful yoga class suitable for all skill levels. We practice various yoga styles including Hatha, Vinyasa, and restorative poses. The class focuses on flexibility, strength, and mindfulness in a welcoming environment.",
        category="Yoga",
        location="Her Strength Women's Fitness Studio - Yoga Room",
        date_and_time=datetime(2024, 2, 7, 18, 0),               # Wednesday 6:00 PM
        age_range="Any",
        contact_information="emma.chen@herstrength.com or (555) 456-7890",
        players_needed=20,
        current_players_count=0,
        players_enrolled=[],
        status="active",
        photo_base64=SAMPLE_IMAGES["yoga"]
    )
    
    # Create all teams in database
    teams = [team1, team2, team3]
    created_teams = []
    
    print("\n" + "="*60)
    print("CREATING ACTIVITY TEAMS IN DATABASE")
    print("="*60)
    
    for i, team in enumerate(teams, 1):
        try:
            created_team = crud.create_group_activity_team_db(team_data=team)
            if created_team:
                created_teams.append(created_team)
                print(f"✅ Team {i}/3 created: {created_team.name}")
                print(f"   ID: {created_team.team_id}")
                print(f"   Category: {created_team.category}")
                print(f"   Players Needed: {created_team.players_needed} people")
                print(f"   Date/Time: {created_team.date_and_time}")
                print(f"   Contact: {created_team.contact_information}")
                print(f"   Age Range: {created_team.age_range}")
                print()
            else:
                print(f"❌ Failed to create team {i}: {team.name}")
        except Exception as e:
            print(f"❌ Error creating team {i}: {e}")
    
    print("="*60)
    print("ACTIVITY TEAM CREATION SUMMARY")
    print("="*60)
    print(f"Total teams created: {len(created_teams)}/3")
    
    if created_teams:
        print("\nCreated Team IDs (save these for testing):")
        for team in created_teams:
            print(f"- {team.name}: {team.team_id}")
        
        print("\n💡 USAGE TIPS:")
        print("1. Use these team IDs to test booking functionality")
        print("2. Test capacity limits by booking multiple users")
        print("3. Each team has different pricing for testing payment flows")
        print("4. Try filtering teams by activity type or difficulty level")
        
        print("\n🏃‍♀️ ACTIVITY CATEGORIES CREATED:")
        category_summary = {}
        for team in created_teams:
            category = team.category
            if category not in category_summary:
                category_summary[category] = []
            category_summary[category].append(f"{team.name} ({team.age_range})")
        
        for category, teams_list in category_summary.items():
            print(f"- {category}: {len(teams_list)} team(s)")
            for team_info in teams_list:
                print(f"  • {team_info}")
        
        print("\n📊 CAPACITY DISTRIBUTION:")
        capacity_count = {}
        for team in created_teams:
            capacity = team.players_needed
            capacity_count[capacity] = capacity_count.get(capacity, 0) + 1
        
        for capacity, count in capacity_count.items():
            print(f"- {capacity} players: {count} team(s)")
        
        print("\n📅 SCHEDULE OVERVIEW:")
        for team in created_teams:
            print(f"- {team.name}: {team.date_and_time.strftime('%A, %B %d at %I:%M %p')}")
    
    return created_teams

if __name__ == "__main__":
    print("🏃‍♀️ SPORTIFY ACTIVITY TEAM CREATION SCRIPT")
    print("="*60)
    print("This script creates 3 comprehensive activity teams with all possible fields.")
    print("Each team represents different activities, difficulty levels, and demographics.")
    print("Perfect for development and testing purposes.")
    print("="*60)
    
    teams = create_comprehensive_activity_teams()
    
    if teams:
        print(f"\n✅ Activity team creation completed successfully!")
        print(f"Created {len(teams)} teams ready for testing.")
        print("\n🎯 NEXT STEPS:")
        print("1. Test booking users into teams")
        print("2. Test capacity limits and waitlists")
        print("3. Test filtering and search functionality")
        print("4. Test payment processing for different price points")
    else:
        print("\n❌ Activity team creation failed!")
        print("Check the error messages above for details.") 