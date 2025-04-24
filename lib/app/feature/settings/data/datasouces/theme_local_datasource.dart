import 'package:newspaper_app/app/config/injection/di.dart';

import '../../domain/entities/theme_preferences.dart';


class ThemeLocalDataSource {
  final _storage = appData;

  Future<void> saveThemePreference(ThemePreference preference) async {
    await _storage.writeIfNull('themePreference', preference.toString());
  }

  ThemePreference getThemePreference() {
    final preference = _storage.read('themePreference');
    if (preference == 'ThemePreference.dark') {
      return ThemePreference.dark;
    } else if (preference == 'ThemePreference.light') {
      return ThemePreference.light;
    } else {
      return ThemePreference.system;
    }
  }
}