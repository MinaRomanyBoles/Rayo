import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StatsRow extends StatelessWidget {
  final double ping;
  final double jitter;
  final double packetLoss;

  const StatsRow({
    super.key,
    required this.ping,
    required this.jitter,
    required this.packetLoss,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.darkSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.darkBorder, width: 0.5),
      ),
      child: Row(
        children: [
          _StatItem(
            icon: Icons.access_time_rounded,
            label: 'PING',
            value: ping.toStringAsFixed(0),
            unit: 'ms',
            color: AppColors.pingColor,
          ),
          _divider(),
          _StatItem(
            icon: Icons.show_chart,
            label: 'JITTER',
            value: jitter.toStringAsFixed(0),
            unit: 'ms',
            color: AppColors.jitterColor,
          ),
          _divider(),
          _StatItem(
            icon: Icons.warning_amber_rounded,
            label: 'LOSS',
            value: packetLoss.toStringAsFixed(1),
            unit: '%',
            color: AppColors.lossColor,
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: 36,
      color: AppColors.darkBorder,
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color color;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 12, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: color,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontFamily: 'AbdElRadyPro',
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.darkTextPrimary,
                  height: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  unit,
                  style: const TextStyle(fontSize: 10, color: AppColors.darkTextSecondary),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
