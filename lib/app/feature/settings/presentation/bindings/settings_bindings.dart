import 'package:get/get.dart';
import 'package:newspaper_app/app/config/injection/di.dart';
import 'package:newspaper_app/app/feature/settings/domain/usecases/save_theme_preferences.dart';

import '../controller/settings_controller.dart';


class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController(saveThemePreference: locator.get<SaveThemePreference>()));
  }
}