import 'package:flutter/material.dart';
import 'package:rayo_broadband_speed_test/core/theme/app_theme.dart';
import 'package:rayo_broadband_speed_test/features/speed_test/presentation/pages/speed_test_page.dart';

void main() {
  runApp(const RayoApp());
}

class RayoApp extends StatelessWidget {
  const RayoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rayo Speed Test',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const SpeedTestPage(),
    );
  }
}
