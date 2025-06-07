import 'package:flutter/material.dart';

class ActivityLeaderboardScreen extends StatelessWidget {
  const ActivityLeaderboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        title: const Text('Activity Leaderboard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Image
            Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage(
                      'assets/images/leaderboard_header.png'), // Assuming you have this asset
                  fit: BoxFit.cover,
                ),
              ),
              child: const Center(
                child: Text(
                  'LEADERBOARD',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Leaderboard Table
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2C2C2E),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    _buildHeaderRow(),
                    const Divider(color: Colors.white24),
                    Expanded(
                      child: ListView(
                        children: [
                          _buildPlayerRow('01', 'Player Name', '05', '20', '17',
                              '06', '03'),
                          _buildPlayerRow('02', 'Player Name', '05', '20', '17',
                              '06', '03'),
                          _buildPlayerRow('03', 'Player Name', '05', '20', '17',
                              '06', '03'),
                          _buildPlayerRow('04', 'Player Name', '05', '20', '17',
                              '06', '03'),
                          _buildPlayerRow('05', 'Player Name', '05', '20', '17',
                              '06', '03'),
                          // Add more players as needed
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      child: Row(
        children: [
          SizedBox(width: 30), // For Rank
          Expanded(
              flex: 3,
              child: Text('PLAYER',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold))),
          Expanded(
              child: Text('G',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text('S',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text('B',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text('A',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text('T',
                  style: TextStyle(
                      color: Colors.white70, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildPlayerRow(String rank, String name, String g, String s, String b,
      String a, String t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(rank,
                style: const TextStyle(
                    color: Color(0xFFEF6A2A),
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
          ),
          Expanded(
            flex: 3,
            child: Text(name,
                style: const TextStyle(color: Colors.white, fontSize: 16)),
          ),
          Expanded(
              child: Text(g,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text(s,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text(b,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text(a,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center)),
          Expanded(
              child: Text(t,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
