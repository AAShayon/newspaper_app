

import '../../domain/entities/theme_preferences.dart';
import '../../domain/repositories/theme_repositories.dart';
import '../datasouces/theme_local_datasource.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDataSource localDataSource;

  ThemeRepositoryImpl(this.localDataSource);

  @override
  Future<void> saveThemePreference(ThemePreference preference) async {
    await localDataSource.saveThemePreference(preference);
  }

  @override
  ThemePreference getThemePreference() {
    return localDataSource.getThemePreference();
  }
}