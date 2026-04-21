import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'user_rank_row.dart';

class CountryRankTile extends StatelessWidget {
  final int rank;
  final String countryName;
  final double avgPing;
  final List<Map<String, dynamic>> users;

  const CountryRankTile({
    super.key,
    required this.rank,
    required this.countryName,
    required this.avgPing,
    required this.users,
  });

  String get _flag {
    // Simple emoji flag mapping
    const flags = {
      'Japan': '🇯🇵', 'South Korea': '🇰🇷', 'UAE': '🇦🇪', 'Egypt': '🇪🇬',
      'USA': '🇺🇸', 'Germany': '🇩🇪', 'UK': '🇬🇧', 'France': '🇫🇷',
      'Saudi Arabia': '🇸🇦', 'India': '🇮🇳', 'China': '🇨🇳', 'Brazil': '🇧🇷',
    };
    return flags[countryName] ?? '🏳️';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.darkBorder, width: 0.5),
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        iconColor: AppColors.darkTextSecondary,
        collapsedIconColor: AppColors.darkTextSecondary,
        leading: Text(
          rank.toString().padLeft(2, '0'),
          style: const TextStyle(
            fontFamily: 'AbdElRadyPro',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.darkTextDisabled,
          ),
        ),
        title: Row(
          children: [
            Text(_flag, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 10),
            Text(
              countryName,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.darkTextPrimary),
            ),
          ],
        ),
        subtitle: Text(
          'Avg Ping: ${avgPing.toStringAsFixed(0)}ms',
          style: const TextStyle(fontSize: 11, color: AppColors.darkTextSecondary),
        ),
        children: users.map((u) => UserRankRow(
          username: u['username'] as String,
          avatarUrl: u['avatar_url'] as String?,
          ping: u['ping'] as double,
          download: u['download'] as double,
          upload: u['upload'] as double,
        )).toList(),
      ),
    );
  }
}
