"""
Add Gym Script for Sportify Backend Development

This script adds comprehensive gyms to the database with all possible fields populated.
Use this during development to create test gyms with realistic data.

USAGE:
    python -m backend.database_data.add_gym

WHAT THIS SCRIPT DOES:
- Creates multiple gyms with ALL possible fields from the Gym model
- Adds various subscription plans for each gym
- Sets up different services offered by each gym
- Configures gender acceptance policies
- Sets token pricing per visit

FIELD EXPLANATIONS:
- gym_id: str - Auto-generated UUID, don't modify
- name: str - Name of the gym (must be descriptive)
- location: str - Physical address or location description
- location_url: Optional[HttpUrl] - Google Maps URL or website URL
- token_per_visit: Optional[float] - Cost per visit in tokens/currency
- genders_accepted: List[str] - ["Male", "Female", "Unisex"] - can have multiple
- subscriptions: List[Subscription] - List of subscription plans
- services: List[str] - List of services offered

SUBSCRIPTION FIELDS:
- name: str - Name of the subscription plan
- length: str - Duration like "1 month", "3 months", "1 year"
- price: float - Price in currency units

SERVICES EXAMPLES:
- Equipment: "Weights", "Cardio", "Machines", "Free Weights"
- Classes: "Yoga", "Pilates", "Zumba", "Spin", "CrossFit"
- Facilities: "Pool", "Sauna", "Steam Room", "Locker Rooms"
- Training: "Personal Training", "Group Training", "Nutrition Counseling"
- Specialized: "Rock Climbing", "Boxing", "Martial Arts", "Dance"

GENDER ACCEPTANCE:
- ["Male"] - Men only gym
- ["Female"] - Women only gym  
- ["Male", "Female"] - Mixed gender with separate areas
- ["Unisex"] - Fully integrated mixed gender

DO NOT:
- Use duplicate gym names in same location
- Set gym_id manually (auto-generated)
- Use invalid URLs for location_url
- Set negative prices or token values
- Leave required fields empty
"""

import sys
import os

# Add the parent directory to the path to import backend modules
sys.path.insert(0, os.path.dirname(os.path.dirname(os.path.abspath(__file__))))

from backend.models import Gym, Subscription
from backend import crud

def create_comprehensive_gyms():
    """
    Creates multiple comprehensive gyms with all possible fields populated.
    This demonstrates every field that can be set on a Gym model.
    """
    
    # Gym 1: Premium Full-Service Gym
    print("Creating Gym 1: Premium Full-Service Gym...")
    gym1 = Gym(
        name="FitLife Premium Fitness Center",                    # str: Gym name
        location="123 Main Street, Downtown, City Center",        # str: Physical address
        location_url="https://maps.google.com/place/fitlife",     # Optional[str]: Google Maps link (will be converted to HttpUrl)
        token_per_visit=15.50,                                    # Optional[float]: Cost per visit
        
        # genders_accepted: List[str] - Who can use this gym
        genders_accepted=["Male", "Female"],                      # Mixed gender gym
        
        # subscriptions: List[Subscription] - Multiple subscription plans
        subscriptions=[
            Subscription(
                name="Basic Monthly",                             # str: Plan name
                length="1 month",                                 # str: Duration
                price=49.99                                       # float: Price
            ),
            Subscription(
                name="Premium Monthly",
                length="1 month", 
                price=79.99
            ),
            Subscription(
                name="Basic Annual",
                length="12 months",
                price=499.99                                      # Annual discount
            ),
            Subscription(
                name="Premium Annual",
                length="12 months",
                price=799.99
            ),
            Subscription(
                name="Student Monthly",
                length="1 month",
                price=29.99                                       # Student discount
            )
        ],
        
        # services: List[str] - All services offered
        services=[
            # Equipment
            "Free Weights",
            "Weight Machines", 
            "Cardio Equipment",
            "Functional Training Area",
            
            # Classes
            "Yoga Classes",
            "Pilates Classes",
            "Zumba Classes",
            "Spin Classes",
            "CrossFit Training",
            "HIIT Classes",
            
            # Facilities
            "Swimming Pool",
            "Sauna",
            "Steam Room",
            "Locker Rooms",
            "Showers",
            "Parking",
            
            # Training Services
            "Personal Training",
            "Group Training",
            "Nutrition Counseling",
            "Fitness Assessment",
            
            # Amenities
            "Towel Service",
            "Smoothie Bar",
            "Childcare",
            "WiFi"
        ]
    )
    
    # Gym 2: Women-Only Boutique Gym
    print("Creating Gym 2: Women-Only Boutique Gym...")
    gym2 = Gym(
        name="Her Strength Women's Fitness Studio",
        location="456 Oak Avenue, Uptown District",
        location_url="https://maps.google.com/place/herstrength",
        token_per_visit=12.00,
        
        genders_accepted=["Female"],                              # Women only
        
        subscriptions=[
            Subscription(
                name="Monthly Unlimited",
                length="1 month",
                price=89.99
            ),
            Subscription(
                name="3-Month Package",
                length="3 months",
                price=239.99
            ),
            Subscription(
                name="Annual Membership",
                length="12 months",
                price=899.99
            ),
            Subscription(
                name="Drop-in Class",
                length="1 day",
                price=25.00
            )
        ],
        
        services=[
            # Specialized Women's Programs
            "Prenatal Fitness",
            "Postnatal Recovery",
            "Women's Strength Training",
            "Barre Classes",
            
            # Mind-Body Classes
            "Yoga",
            "Meditation",
            "Pilates",
            "Tai Chi",
            
            # High-Energy Classes
            "Dance Fitness",
            "Kickboxing",
            "Circuit Training",
            
            # Facilities
            "Private Changing Rooms",
            "Nursing Room",
            "Childcare",
            "Healthy Cafe",
            
            # Services
            "Personal Training",
            "Nutritionist Consultation",
            "Massage Therapy",
            "Beauty Services"
        ]
    )
    
    # Gym 3: Budget-Friendly 24/7 Gym
    print("Creating Gym 3: Budget-Friendly 24/7 Gym...")
    gym3 = Gym(
        name="24/7 Fitness Express",
        location="789 Industrial Blvd, Suburb Area",
        location_url="https://maps.google.com/place/247fitness",
        token_per_visit=8.99,                                     # Budget pricing
        
        genders_accepted=["Unisex"],                              # Fully integrated
        
        subscriptions=[
            Subscription(
                name="Basic Access",
                length="1 month",
                price=19.99                                       # Very affordable
            ),
            Subscription(
                name="Premium Access",
                length="1 month",
                price=29.99
            ),
            Subscription(
                name="Annual Basic",
                length="12 months",
                price=199.99
            ),
            Subscription(
                name="Annual Premium",
                length="12 months",
                price=299.99
            )
        ],
        
        services=[
            # Basic Equipment
            "Cardio Machines",
            "Free Weights",
            "Weight Machines",
            "Stretching Area",
            
            # 24/7 Features
            "24/7 Access",
            "Keycard Entry",
            "Security Cameras",
            
            # Basic Amenities
            "Locker Rooms",
            "Showers",
            "Water Fountains",
            "Free Parking",
            
            # Limited Classes
            "Virtual Classes",
            "Weekend Group Sessions"
        ]
    )
    
    # Gym 4: Specialized Combat Sports Gym
    print("Creating Gym 4: Specialized Combat Sports Gym...")
    gym4 = Gym(
        name="Iron Fist Combat Academy",
        location="321 Fighter's Way, Sports District",
        location_url="https://maps.google.com/place/ironfist",
        token_per_visit=20.00,                                    # Specialized pricing
        
        genders_accepted=["Male", "Female"],                      # Mixed with separate training areas
        
        subscriptions=[
            Subscription(
                name="Beginner Package",
                length="1 month",
                price=99.99
            ),
            Subscription(
                name="Intermediate Package", 
                length="1 month",
                price=129.99
            ),
            Subscription(
                name="Advanced Fighter",
                length="1 month",
                price=159.99
            ),
            Subscription(
                name="Competition Prep",
                length="3 months",
                price=449.99
            )
        ],
        
        services=[
            # Combat Sports
            "Boxing Training",
            "Muay Thai",
            "Brazilian Jiu-Jitsu",
            "Mixed Martial Arts (MMA)",
            "Kickboxing",
            "Wrestling",
            
            # Equipment
            "Heavy Bags",
            "Speed Bags",
            "Boxing Ring",
            "Grappling Mats",
            "Strength Training Equipment",
            
            # Training
            "Private Coaching",
            "Group Classes",
            "Sparring Sessions",
            "Competition Training",
            
            # Facilities
            "Men's Locker Room",
            "Women's Locker Room",
            "Recovery Area",
            "Pro Shop",
            
            # Specialized Services
            "Fight Preparation",
            "Technique Analysis",
            "Conditioning Programs"
        ]
    )
    
    # Gym 5: Luxury Wellness Center
    print("Creating Gym 5: Luxury Wellness Center...")
    gym5 = Gym(
        name="Zenith Wellness & Spa",
        location="555 Luxury Lane, Elite District",
        location_url="https://maps.google.com/place/zenithwellness",
        token_per_visit=35.00,                                    # Premium pricing
        
        genders_accepted=["Male", "Female"],                      # Luxury mixed facility
        
        subscriptions=[
            Subscription(
                name="Wellness Monthly",
                length="1 month",
                price=199.99
            ),
            Subscription(
                name="Elite Monthly",
                length="1 month",
                price=299.99
            ),
            Subscription(
                name="Platinum Annual",
                length="12 months",
                price=2999.99                                     # Luxury pricing
            ),
            Subscription(
                name="Corporate Package",
                length="12 months",
                price=3999.99
            )
        ],
        
        services=[
            # Fitness
            "State-of-the-Art Equipment",
            "Personal Training",
            "Small Group Training",
            "Functional Movement",
            
            # Wellness Classes
            "Hot Yoga",
            "Meditation Classes",
            "Breathwork Sessions",
            "Mindfulness Training",
            
            # Spa Services
            "Massage Therapy",
            "Facial Treatments",
            "Body Treatments",
            "Acupuncture",
            "Cryotherapy",
            
            # Luxury Facilities
            "Infinity Pool",
            "Jacuzzi",
            "Steam Room",
            "Sauna",
            "Salt Room",
            "Relaxation Lounge",
            
            # Premium Amenities
            "Valet Parking",
            "Concierge Service",
            "Healthy Restaurant",
            "Juice Bar",
            "Retail Boutique",
            "Towel and Robe Service",
            
            # Specialized Programs
            "Executive Fitness",
            "Stress Management",
            "Sleep Optimization",
            "Nutrition Coaching"
        ]
    )
    
    # Create all gyms in database
    gyms = [gym1, gym2, gym3, gym4, gym5]
    created_gyms = []
    
    print("\n" + "="*60)
    print("CREATING GYMS IN DATABASE")
    print("="*60)
    
    for i, gym in enumerate(gyms, 1):
        try:
            created_gym = crud.create_gym_db(gym_data=gym)
            if created_gym:
                created_gyms.append(created_gym)
                print(f"✅ Gym {i}/5 created: {created_gym.name}")
                print(f"   ID: {created_gym.gym_id}")
                print(f"   Location: {created_gym.location}")
                print(f"   Token per visit: ${created_gym.token_per_visit}")
                print(f"   Genders: {', '.join(created_gym.genders_accepted)}")
                print(f"   Subscriptions: {len(created_gym.subscriptions)} plans")
                print(f"   Services: {len(created_gym.services)} services")
                print()
            else:
                print(f"❌ Failed to create gym {i}: {gym.name}")
        except Exception as e:
            print(f"❌ Error creating gym {i}: {e}")
    
    print("="*60)
    print("GYM CREATION SUMMARY")
    print("="*60)
    print(f"Total gyms created: {len(created_gyms)}/5")
    
    if created_gyms:
        print("\nCreated Gym IDs (save these for testing):")
        for gym in created_gyms:
            print(f"- {gym.name}: {gym.gym_id}")
        
        print("\n💡 USAGE TIPS:")
        print("1. Use these gym IDs to add to user favourites")
        print("2. Test the 'around you' endpoint with different coordinates")
        print("3. Each gym has different pricing and services for testing")
        print("4. Try filtering by gender acceptance in your app")
        
        print("\n🏋️‍♀️ GYM TYPES CREATED:")
        print("1. Premium Full-Service (Mixed gender, comprehensive)")
        print("2. Women-Only Boutique (Female only, specialized)")
        print("3. Budget 24/7 (Unisex, basic)")
        print("4. Combat Sports (Mixed, specialized)")
        print("5. Luxury Wellness (Mixed, premium)")
    
    return created_gyms

if __name__ == "__main__":
    print("🏋️‍♂️ SPORTIFY GYM CREATION SCRIPT")
    print("="*60)
    print("This script creates 5 comprehensive gyms with all possible fields.")
    print("Each gym represents a different type of fitness facility.")
    print("Perfect for development and testing purposes.")
    print("="*60)
    
    gyms = create_comprehensive_gyms()
    
    if gyms:
        print(f"\n✅ Gym creation completed successfully!")
        print(f"Created {len(gyms)} gyms ready for testing.")
    else:
        print("\n❌ Gym creation failed!")
        print("Check the error messages above for details.") 