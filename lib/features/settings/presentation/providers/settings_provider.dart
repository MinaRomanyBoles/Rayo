import 'package:flutter/material.dart';

class SettingsProvider extends ChangeNotifier {
  String? _appVersion;
  String get appVersion => _appVersion ?? '1.0.0';

  SettingsProvider() {
    _appVersion = '1.0.0';
  }
}
