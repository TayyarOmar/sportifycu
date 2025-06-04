# Database Data Scripts for Sportify Backend

This directory contains comprehensive scripts for populating the Sportify database with realistic test data during development. Each script creates entities with ALL possible fields populated, making them perfect for testing and development purposes.

## 📁 Scripts Overview

### 🏃‍♂️ `add_user.py`
Creates a comprehensive user with all possible fields:
- **Basic Info**: Name, email, password, age, gender
- **2FA Setup**: Generates and enables 2FA with secret key
- **Fitness Data**: Goals, achievements, notification preferences
- **Activity Logs**: Multiple running, steps, and gym time entries
- **Relationships**: Empty favourites and bookings (to be populated after gyms/teams exist)

### 🏋️‍♀️ `add_gym.py`
Creates 5 different types of gyms:
1. **Premium Full-Service** - Mixed gender, comprehensive services
2. **Women-Only Boutique** - Female only, specialized programs
3. **Budget 24/7** - Unisex, basic amenities
4. **Combat Sports** - Mixed, specialized martial arts
5. **Luxury Wellness** - Mixed, premium spa services

Each gym includes:
- Multiple subscription plans with different pricing
- Comprehensive service lists
- Gender acceptance policies
- Token pricing per visit
- Location and contact information

### 🏃‍♀️ `add_group_activity_team.py`
Creates 10 diverse activity teams:
1. **Morning Joggers Club** (Running, Beginner)
2. **Elite CrossFit Warriors** (CrossFit, Advanced)
3. **Sunset Yoga Flow** (Yoga, All Levels)
4. **Aqua Fitness Squad** (Swimming, Intermediate)
5. **Boxing Fundamentals** (Boxing, Beginner)
6. **Zumba Explosion** (Zumba, All Levels)
7. **Weekend Warriors Hiking Club** (Hiking, Intermediate)
8. **Golden Years Fitness** (Low-Impact, Beginner)
9. **HIIT Bootcamp** (HIIT, Intermediate)
10. **Mindful Moments Circle** (Meditation, All Levels)

Each team includes:
- Detailed descriptions and requirements
- Capacity limits and pricing
- Instructor information
- Schedules and locations
- Equipment and experience requirements

## 🚀 Usage Instructions

### Prerequisites
Make sure you have:
- Backend dependencies installed (`uv install`)
- Database properly configured
- All backend modules accessible

### Running the Scripts

#### Option 1: Run Individual Scripts
```bash
# From the project root directory
python -m backend.database_data.add_user
python -m backend.database_data.add_gym
python -m backend.database_data.add_group_activity_team
```

#### Option 2: Run All Scripts in Sequence
```bash
# Create a comprehensive test environment
python -m backend.database_data.add_user && \
python -m backend.database_data.add_gym && \
python -m backend.database_data.add_group_activity_team
```

### Recommended Order
1. **Users first** - Creates test users for authentication testing
2. **Gyms second** - Creates gym data for location-based features
3. **Teams third** - Creates activity teams for booking functionality

## 📊 What Gets Created

### User Data
- **1 User** with comprehensive profile
- **12 Activity logs** (running, steps, gym time)
- **5 Fitness goals** (weight loss, muscle gain, etc.)
- **5 Achievements** (first workout, 5K runner, etc.)
- **2FA enabled** with generated secret key

### Gym Data
- **5 Gyms** with different characteristics
- **20+ Subscription plans** across all gyms
- **100+ Services** covering all fitness needs
- **Different pricing models** ($8.99 - $35.00 per visit)
- **Various gender policies** (Male, Female, Unisex)

### Activity Team Data
- **10 Teams** covering diverse activities
- **Different difficulty levels** (Beginner to Advanced)
- **Capacity range** (8-25 participants)
- **Pricing variety** ($5.00 - $25.00 per session)
- **Comprehensive requirements** lists

## 🔧 Customization

### Modifying User Data
Edit `add_user.py` to change:
- User personal information
- Activity log entries and dates
- Fitness goals and achievements
- 2FA preferences

### Adding More Gyms
Edit `add_gym.py` to:
- Add new gym types
- Modify subscription plans
- Change service offerings
- Adjust pricing models

### Creating Different Teams
Edit `add_group_activity_team.py` to:
- Add new activity types
- Modify capacity and pricing
- Change schedules and locations
- Update requirements lists

## 🧪 Testing Scenarios

### Authentication Testing
- Use created user credentials for login testing
- Test 2FA flow with generated secret key
- Verify password reset functionality

### Gym Discovery Testing
- Test "gyms around you" with different coordinates
- Filter gyms by gender acceptance
- Test subscription plan selection
- Verify pricing calculations

### Activity Team Testing
- Test booking functionality with capacity limits
- Filter teams by activity type and difficulty
- Test pricing and payment flows
- Verify requirement validation

### Integration Testing
- Add gym IDs to user favourites
- Book users into activity teams
- Test leaderboard with activity scores
- Verify notification preferences

## 📝 Field Documentation

### User Model Fields
```python
user_id: str                    # Auto-generated UUID
name: str                       # Full name
email: EmailStr                 # Unique email address
hashed_password: str            # Bcrypt hashed password
gender: Optional[str]           # "Male", "Female", "Other", None
age: Optional[int]              # Age in years
fitness_goals: List[str]        # Multiple fitness objectives
two_fa_key: str                 # TOTP secret key
is_2fa_enabled: bool           # 2FA status
tracked_activities: List[ActivityLog]  # Activity history
favourites: List[str]          # Gym IDs
achievements: List[str]        # Achievement names
notification_setting: bool    # Notification preference
bookings: List[str]           # Team IDs
```

### Gym Model Fields
```python
gym_id: str                    # Auto-generated UUID
name: str                      # Gym name
location: str                  # Physical address
location_url: Optional[HttpUrl] # Google Maps URL
token_per_visit: Optional[float] # Cost per visit
genders_accepted: List[str]    # ["Male", "Female", "Unisex"]
subscriptions: List[Subscription] # Subscription plans
services: List[str]           # Services offered
```

### Activity Team Model Fields
```python
team_id: str                   # Auto-generated UUID
name: str                      # Team name
activity_type: str             # Activity category
description: str               # Detailed description
max_capacity: int              # Maximum participants
current_bookings: int          # Current bookings
price_per_session: Optional[float] # Cost per session
difficulty_level: str          # Skill level required
schedule: str                  # Meeting schedule
location: str                  # Meeting location
instructor_name: Optional[str] # Instructor name
players_enrolled: List[str]    # User IDs who joined
status: str                   # Team status
photo_base64: Optional[str]   # Base64 encoded photo data
```

## ⚠️ Important Notes

### Database Persistence
- All scripts modify the **real database**
- Data persists between runs
- Use with caution in production environments

### Duplicate Prevention
- User emails must be unique
- Gym names should be unique per location
- Team names should be unique per activity type

### Error Handling
- Scripts include comprehensive error handling
- Failed operations are logged with details
- Partial failures don't stop script execution

### Dependencies
- Scripts use existing CRUD operations
- Rely on backend models and schemas
- Require all backend dependencies

## 🎯 Development Workflow

1. **Initial Setup**: Run all scripts to create base data
2. **Feature Testing**: Use created entities for specific feature testing
3. **Data Cleanup**: Clear database and re-run scripts as needed
4. **Customization**: Modify scripts for specific testing scenarios

## 📞 Support

If you encounter issues:
1. Check that all backend dependencies are installed
2. Verify database connectivity
3. Ensure proper Python path configuration
4. Review error messages for specific issues

These scripts provide a solid foundation for development and testing of the Sportify backend system! 