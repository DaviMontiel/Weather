import 'package:flutter/material.dart';
import '../data/services/settings_service.dart';

final settingsController = SettingsController();

class SettingsController with ChangeNotifier {
  
  final SettingsService _settingsService = SettingsService();
  late ThemeMode _themeMode;

  ThemeMode get themeMode => _themeMode;


  Future<void> loadSettings() async {
    _themeMode = await _settingsService.themeMode();

    // Important! Inform listeners a change has occurred.
    notifyListeners();
  }

  Future<void> updateThemeMode(ThemeMode? newThemeMode) async {
    if (newThemeMode == null) return;

    // Do not perform any work if new and old ThemeMode are identical
    if (newThemeMode == _themeMode) return;

    // Otherwise, store the new ThemeMode in memory
    _themeMode = newThemeMode;

    // Important! Inform listeners a change has occurred.
    notifyListeners();

    // Persist the changes to a local database or the internet using the
    // SettingService.
    await _settingsService.updateThemeMode(newThemeMode);
  }
}