import 'package:flutter/material.dart';

Map<String, dynamic> getDummyGymData(String gymId) {
  switch (gymId) {
    case '1': // Grams Gym
      return {
        'image': 'assets/images/GramsGymExplore.png',
        'website': 'https://www.instagram.com/gramsgym/?hl=ar',
        'phone': 'tel:0799006646',
        'location': {'lat': 31.94653392952973, 'lon': 35.84747769325328},
        'rating': 4,
        'amenities': [
          'Shower rooms',
          'Locker rooms',
          'Free WiFi',
          '24/7 Access',
          'Free Parking',
          'Cardio Sessions'
        ],
        'services': [
          {'name': 'Sauna', 'icon': Icons.thermostat},
          {'name': 'Personal Trainer', 'icon': Icons.sports},
          {'name': 'Swimming Pool', 'icon': Icons.pool},
        ],
        'subscriptions': [
          {'label': '1 Month: 80 JD'},
          {'label': '3 Months: 200 JD'},
          {'label': '6 Months: 350 JD'},
        ],
        'schedule': [
          {'dayNum': '14', 'dayName': 'MON'},
          {'dayNum': '15', 'dayName': 'TUE'},
          {'dayNum': '16', 'dayName': 'WED'},
          {'dayNum': '17', 'dayName': 'THU'},
        ],
        'classes': [
          {
            'name': 'CrossFit - 60 Mins',
            'instructor': 'Ahmed',
            'time': '8:00 AM'
          },
          {
            'name': 'Powerlifting - 90 Mins',
            'instructor': 'Khalid',
            'time': '6:00 PM'
          },
        ]
      };
    case '2': // X Gym
      return {
        'image': 'assets/images/Xgymcover.jpg',
        'website': 'https://www.instagram.com/xgym_jo/?hl=ar',
        'phone': 'tel:0799006646',
        'location': {'lat': 31.958910340571794, 'lon': 35.8486217939794},
        'rating': 5,
        'amenities': [
          'Shower rooms',
          'Locker rooms',
          'Free WiFi',
          'Special Needs Accessible',
          'Free Parking',
          'Free Trial',
        ],
        'services': [
          {'name': 'Yoga', 'icon': Icons.self_improvement},
          {'name': 'Personal Trainer', 'icon': Icons.sports},
        ],
        'subscriptions': [
          {'label': '1 Month: 90 JD'},
          {'label': 'Special Offer: 120 JD/100Days'},
        ],
        'schedule': [
          {'dayNum': '18', 'dayName': 'FRI'},
          {'dayNum': '19', 'dayName': 'SAT'},
        ],
        'classes': [
          {'name': 'Zumba - 55 Mins', 'instructor': 'Sara', 'time': '10:00 AM'},
          {
            'name': 'H.I.I.T - 45 Mins',
            'instructor': 'Mike',
            'time': '7:00 PM'
          },
        ]
      };
    case '3': // Gold's Gym
    default:
      return {
        'image': 'assets/images/GoldsGymExplore.png',
        'website': 'https://www.goldsgym.com/',
        'phone': 'tel:+96264001222', // Standard format for international calls
        'location': {'lat': 31.981386985052904, 'lon': 35.840537296119706},
        'rating': 5,
        'amenities': [
          'Shower rooms',
          'Locker rooms',
          'Free WiFi',
          'Special Needs Accessible',
          'Free Parking',
          'Cardio Sessions',
          'Free Trial',
        ],
        'services': [
          {'name': 'Sauna', 'icon': Icons.thermostat},
          {'name': 'Personal Trainer', 'icon': Icons.sports},
          {'name': 'Swimming Pool', 'icon': Icons.pool},
        ],
        'subscriptions': [
          {'label': '1 Month: 65 JD'},
          {'label': 'Special Offer: 100 JD/100Days'},
          {'label': '6 Months: 250 JD'},
        ],
        'schedule': [
          {'dayNum': '14', 'dayName': 'MON'},
          {'dayNum': '15', 'dayName': 'TUE'},
          {'dayNum': '16', 'dayName': 'WED'},
          {'dayNum': '17', 'dayName': 'THU'},
          {'dayNum': '18', 'dayName': 'SAT'},
          {'dayNum': '19', 'dayName': 'SUN'},
        ],
        'classes': [
          {
            'name': 'Reformer Pilates - 55 Mins',
            'instructor': 'Kelly Brooke',
            'time': '9:00 AM'
          },
          {
            'name': 'Boxing - 55 Mins',
            'instructor': 'Sasha Holly',
            'time': '10:00 AM'
          },
          {
            'name': 'Cycling - 55 Mins',
            'instructor': 'Ryan Johnson',
            'time': '8:00 AM'
          },
        ]
      };
  }
}
