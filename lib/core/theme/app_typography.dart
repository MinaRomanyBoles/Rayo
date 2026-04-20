import 'package:flutter/material.dart';

class AppTypography {
  AppTypography._();

  // ==========================================
  // 🔤 1. عائلة الخط (مطابق لتصميم Figma)
  // ==========================================
  /// خط Inter الهندسي - مستخدم في التصميم كخط رئيسي
  static const String fontFamily = 'Inter';

  // ==========================================
  // 🖋️ 2. الأوزان الأساسية
  // ==========================================
  static const TextStyle thin = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w100,
  );

  static const TextStyle extraLight = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w200,
  );

  static const TextStyle light = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w300,
  );

  static const TextStyle regular = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle medium = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle semiBold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle extraBold = TextStyle(
    fontFamily: fontFamily,
    fontWeight: FontWeight.w800,
  );

  // ==========================================
  // 📜 3. بناء TextTheme بناءً على لون النص
  // ==========================================
  static TextTheme getTextTheme(Color textColor) {
    return TextTheme(
      // ─── Display: أرقام السرعة الكبيرة (428 Mbps)
      displayLarge: extraBold.copyWith(
        fontSize: 72,
        color: textColor,
        letterSpacing: -1.5,
        height: 1.0,
      ),
      displayMedium: bold.copyWith(
        fontSize: 56,
        color: textColor,
        letterSpacing: -1.0,
        height: 1.1,
      ),
      displaySmall: bold.copyWith(
        fontSize: 40,
        color: textColor,
        letterSpacing: -0.5,
        height: 1.1,
      ),

      // ─── Headline: عناوين الصفحات (Test History, Network Rankings)
      headlineLarge: bold.copyWith(
        fontSize: 28,
        color: textColor,
        letterSpacing: -0.5,
        height: 1.2,
      ),
      headlineMedium: semiBold.copyWith(
        fontSize: 24,
        color: textColor,
        height: 1.3,
      ),
      headlineSmall: semiBold.copyWith(
        fontSize: 20,
        color: textColor,
        height: 1.3,
      ),

      // ─── Title: عناوين الكروت والأقسام
      titleLarge: semiBold.copyWith(
        fontSize: 18,
        color: textColor,
        height: 1.4,
      ),
      titleMedium: medium.copyWith(
        fontSize: 16,
        color: textColor,
        letterSpacing: 0.15,
        height: 1.4,
      ),
      titleSmall: medium.copyWith(
        fontSize: 14,
        color: textColor,
        letterSpacing: 0.1,
        height: 1.4,
      ),

      // ─── Body: النصوص العادية والأوصاف
      bodyLarge: regular.copyWith(
        fontSize: 16,
        color: textColor,
        height: 1.5,
      ),
      bodyMedium: regular.copyWith(
        fontSize: 14,
        color: textColor,
        height: 1.5,
      ),
      bodySmall: regular.copyWith(
        fontSize: 12,
        color: textColor,
        height: 1.5,
      ),

      // ─── Label: التسميات والأزرار وشريط التنقل
      labelLarge: semiBold.copyWith(
        fontSize: 14,
        color: textColor,
        letterSpacing: 0.5,
        height: 1.4,
      ),
      labelMedium: medium.copyWith(
        fontSize: 12,
        color: textColor,
        letterSpacing: 0.5,
        height: 1.4,
      ),
      labelSmall: medium.copyWith(
        fontSize: 10,
        color: textColor,
        letterSpacing: 0.5,
        height: 1.4,
      ),
    );
  }
}