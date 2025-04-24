import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/theme/app_theme.dart';
import '../../domain/entities/theme_preferences.dart';
import '../../domain/usecases/save_theme_preferences.dart';

class SettingsController extends GetxController {
  final SaveThemePreference saveThemePreference;
  final Rx<ThemeMode> selectedTheme = ThemeMode.system.obs;

  SettingsController({required this.saveThemePreference});

  @override
  void onInit() {
    super.onInit();
    _loadThemePreference();
  }

  void _loadThemePreference() {
    final currentTheme = AppTheme.currentTheme.value;
    selectedTheme.value = currentTheme;
  }

  void updateTheme(ThemeMode mode) {
    AppTheme.updateTheme(mode);
    selectedTheme.value = mode;
    saveThemePreference(ThemePreference.values[mode.index]);
  }
}