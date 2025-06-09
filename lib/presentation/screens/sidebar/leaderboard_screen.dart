import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify_app/models/leaderboard_entry.dart';
import 'package:sportify_app/providers/leaderboard_provider.dart';
import 'package:sportify_app/utils/app_colors.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key});

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LeaderboardProvider>(context, listen: false)
          .fetchLeaderboard();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Leaderboard'),
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Consumer<LeaderboardProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.errorMessage != null) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }
          if (provider.leaderboard.isEmpty) {
            return const Center(child: Text('Leaderboard is empty.'));
          }

          final topThree = provider.leaderboard.take(3).toList();
          final rest = provider.leaderboard.skip(3).toList();

          return Column(
            children: [
              _buildTopThree(topThree),
              const SizedBox(height: 16),
              Expanded(child: _buildRestOfList(rest)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTopThree(List<LeaderboardEntry> topThree) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (topThree.length > 1)
            _TopPlayerWidget(
              entry: topThree[1],
              rank: 2,
              color: const Color(0xFFC0C0C0),
            ),
          if (topThree.isNotEmpty)
            _TopPlayerWidget(
              entry: topThree[0],
              rank: 1,
              color: const Color(0xFFFFD700),
            ),
          if (topThree.length > 2)
            _TopPlayerWidget(
              entry: topThree[2],
              rank: 3,
              color: const Color(0xFFCD7F32),
            ),
        ],
      ),
    );
  }

  Widget _buildRestOfList(List<LeaderboardEntry> rest) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: rest.length,
      itemBuilder: (context, index) {
        final entry = rest[index];
        final rank = index + 4;
        return _LeaderboardListItem(entry: entry, rank: rank);
      },
    );
  }
}

class _TopPlayerWidget extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;
  final Color color;
  final double? height;

  const _TopPlayerWidget(
      {required this.entry,
      required this.rank,
      required this.color,
      this.height});

  @override
  Widget build(BuildContext context) {
    final double barHeight = rank == 1
        ? 80
        : rank == 2
            ? 60
            : 40;
    final Color barColor = rank == 1
        ? const Color(0xFFFFD700) // Gold
        : rank == 2
            ? const Color(0xFFC0C0C0) // Silver
            : const Color(0xFFCD7F32); // Bronze

    return Container(
      width: 100,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: barColor.withOpacity(0.3),
            child: Text(rank.toString(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          ),
          const SizedBox(height: 8),
          Text(
            entry.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            '${entry.score.toInt()} pts',
            style: TextStyle(fontSize: 13, color: Colors.grey[400]),
          ),
          const SizedBox(height: 6),
          Container(
            height: barHeight,
            width: 80,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LeaderboardListItem extends StatelessWidget {
  final LeaderboardEntry entry;
  final int rank;

  const _LeaderboardListItem({required this.entry, required this.rank});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Text(
              rank.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.textTertiary),
            ),
            const SizedBox(width: 16),
            const CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 24, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    entry.email,
                    style: const TextStyle(color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
            Text(
              '${entry.score.toStringAsFixed(0)} pts',
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}
