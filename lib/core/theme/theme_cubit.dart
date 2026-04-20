import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit للتحكم في وضع الثيم (مظلم / مضيء / نظام)
/// التصميم الأساسي في Figma هو Dark Mode لذلك الافتراضي هو ThemeMode.dark
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.dark);

  /// التبديل بين الوضع المضيء والمظلم
  void toggleTheme() {
    if (state == ThemeMode.dark) {
      emit(ThemeMode.light);
    } else {
      emit(ThemeMode.dark);
    }
  }

  /// تحديد ثيم معين مباشرة (مفيدة لصفحة الإعدادات)
  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
  }

  /// هل الوضع الحالي مظلم؟
  bool get isDarkMode => state == ThemeMode.dark;
}