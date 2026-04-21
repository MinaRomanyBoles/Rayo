import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class UserRankRow extends StatelessWidget {
  final String username;
  final String? avatarUrl;
  final double ping;
  final double download;
  final double upload;

  const UserRankRow({
    super.key,
    required this.username,
    this.avatarUrl,
    required this.ping,
    required this.download,
    required this.upload,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.darkSurfaceVariant,
            backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
            child: avatarUrl == null
                ? const Icon(Icons.person, size: 16, color: AppColors.darkTextSecondary)
                : null,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(username,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: AppColors.darkTextPrimary)),
          ),
          Text('${ping.toStringAsFixed(0)}ms',
            style: const TextStyle(fontSize: 11, color: AppColors.darkTextSecondary)),
          const SizedBox(width: 16),
          Text('${download.toStringAsFixed(0)}M',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.downloadColor)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_downward, size: 10, color: AppColors.downloadColor),
          const SizedBox(width: 12),
          Text('${upload.toStringAsFixed(0)}M',
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.uploadColor)),
          const SizedBox(width: 4),
          const Icon(Icons.arrow_upward, size: 10, color: AppColors.uploadColor),
        ],
      ),
    );
  }
}
