
import '../entities/theme_preferences.dart';
import '../repositories/theme_repositories.dart';

class SaveThemePreference {
  final ThemeRepository repository;

  SaveThemePreference(this.repository);

  Future<void> call(ThemePreference preference) async {
    await repository.saveThemePreference(preference);
  }
}