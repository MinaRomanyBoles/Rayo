import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../speed_test/domain/entities/speed_test_result.dart';

class HistoryCard extends StatelessWidget {
  final SpeedTestResult result;

  const HistoryCard({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final dateFmt = DateFormat('dd MMM yyyy — HH:mm');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder, width: 0.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date & Network
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                dateFmt.format(result.testedAt),
                style: const TextStyle(fontSize: 12, color: AppColors.darkTextSecondary),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  result.networkType,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // Speeds
          Row(
            children: [
              _SpeedMetric(
                icon: Icons.arrow_downward,
                label: 'DOWNLOAD',
                value: result.downloadSpeed.toStringAsFixed(1),
                unit: 'Mbps',
                color: AppColors.downloadColor,
              ),
              const SizedBox(width: 16),
              _SpeedMetric(
                icon: Icons.arrow_upward,
                label: 'UPLOAD',
                value: result.uploadSpeed.toStringAsFixed(1),
                unit: 'Mbps',
                color: AppColors.uploadColor,
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1, color: AppColors.darkBorder),
          const SizedBox(height: 12),
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _MiniStat(label: 'PING', value: '${result.ping.toStringAsFixed(0)}ms', color: AppColors.pingColor),
              _MiniStat(label: 'JITTER', value: '${result.jitter.toStringAsFixed(0)}ms', color: AppColors.jitterColor),
              _MiniStat(label: 'LOSS', value: '${result.packetLoss.toStringAsFixed(1)}%', color: AppColors.lossColor),
            ],
          ),
        ],
      ),
    );
  }
}

class _SpeedMetric extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _SpeedMetric({
    required this.icon, required this.label, required this.value,
    required this.unit, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color, letterSpacing: 1)),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(value, style: const TextStyle(fontFamily: 'AbdElRadyPro', fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary, height: 1.0)),
                  const SizedBox(width: 3),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(unit, style: const TextStyle(fontSize: 10, color: AppColors.darkTextSecondary)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _MiniStat({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.w600, color: color, letterSpacing: 0.5)),
        Text(value, style: const TextStyle(fontFamily: 'AbdElRadyPro', fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.darkTextPrimary)),
      ],
    );
  }
}
