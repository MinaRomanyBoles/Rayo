import 'package:flutter/material.dart';

/// Placeholder Speed Test Page
/// Replace with full BLoC-driven implementation
class SpeedTestPage extends StatelessWidget {
  const SpeedTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.speed, size: 80, color: Color(0xFF00D4FF)),
            const SizedBox(height: 24),
            Text(
              'Rayo Speed Test',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: const Color(0xFF00D4FF),
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Feature-based architecture ready',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white54,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
