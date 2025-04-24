import '../entities/theme_preferences.dart';

abstract class ThemeRepository {
  Future<void> saveThemePreference(ThemePreference preference);
  ThemePreference getThemePreference();
}