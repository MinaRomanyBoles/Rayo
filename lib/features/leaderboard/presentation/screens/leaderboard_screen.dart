import 'package:flutter/material.dart';
import 'package:rayo_broadband_speed_test/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/leaderboard_provider.dart';
import '../widgets/country_rank_tile.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final lb = context.watch<LeaderboardProvider>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(l10n.networkRankings,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary)),
                  const SizedBox(height: 4),
                  Text(l10n.rankingsSubtitle,
                    style: const TextStyle(fontSize: 14, color: AppColors.darkTextSecondary)),
                  const SizedBox(height: 20),
                  // Tab Bar
                  Row(
                    children: [
                      _TabButton(
                        label: l10n.globalCountries,
                        isActive: lb.isGlobalTab,
                        onTap: () => lb.setTab(true),
                      ),
                      const SizedBox(width: 12),
                      _TabButton(
                        label: l10n.localGovernorates,
                        isActive: !lb.isGlobalTab,
                        onTap: () => lb.setTab(false),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: lb.isLoading
                  ? _buildShimmer()
                  : lb.rankings.isEmpty
                      ? Center(
                          child: Text(l10n.noHistory, style: const TextStyle(color: AppColors.darkTextSecondary)),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: lb.rankings.length,
                          itemBuilder: (context, index) {
                            final rank = lb.rankings[index];
                            return CountryRankTile(
                              rank: index + 1,
                              countryName: rank['name'] as String,
                              avgPing: rank['avgPing'] as double,
                              users: (rank['users'] as List).cast<Map<String, dynamic>>(),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: AppColors.darkSurface,
      highlightColor: AppColors.darkSurfaceVariant,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: 5,
        itemBuilder: (_, _) => Container(
          height: 72,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.darkSurface,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: isActive ? AppColors.primary : AppColors.secondary,
              width: 1.5,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? Colors.black : AppColors.secondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
