import 'package:flutter/material.dart';
import 'package:rayo_broadband_speed_test/l10n/generated/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/history_provider.dart';
import '../widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HistoryProvider>().fetchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final history = context.watch<HistoryProvider>();

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
                  Text(l10n.testHistory,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary)),
                  const SizedBox(height: 4),
                  Text(l10n.historySubtitle,
                    style: const TextStyle(fontSize: 14, color: AppColors.darkTextSecondary)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: history.isLoading
                  ? _buildShimmer()
                  : history.results.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.history, size: 56, color: AppColors.darkTextDisabled.withValues(alpha: 0.3)),
                              const SizedBox(height: 12),
                              Text(l10n.noHistory,
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 14, color: AppColors.darkTextSecondary)),
                            ],
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: history.results.length,
                          itemBuilder: (context, index) => HistoryCard(result: history.results[index]),
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
        itemCount: 4,
        itemBuilder: (_, _) => Container(
          height: 140,
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(color: AppColors.darkSurface, borderRadius: BorderRadius.circular(16)),
        ),
      ),
    );
  }
}
