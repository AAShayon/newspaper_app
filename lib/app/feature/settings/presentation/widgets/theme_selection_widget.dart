import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';

import '../controller/settings_controller.dart';


class ThemeSelectionWidget extends StatelessWidget {
  final SettingsController controller = Get.find();

    ThemeSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final currentTheme = controller.selectedTheme.value;
      return Column(
        children: [
          RadioListTile<ThemeMode>(
            title: Text("System Default"),
            value: ThemeMode.system,
            groupValue: currentTheme,
            onChanged: (value) {
              controller.updateTheme(value!);
              NavigationService.goBack();
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text("Light Mode"),
            value: ThemeMode.light,
            groupValue: currentTheme,
            onChanged: (value) {
              controller.updateTheme(value!);
              NavigationService.goBack();
            },
          ),
          RadioListTile<ThemeMode>(
            title: Text("Dark Mode"),
            value: ThemeMode.dark,
            groupValue: currentTheme,
            onChanged: (value) {
              controller.updateTheme(value!);
              NavigationService.goBack();
            },
          ),
        ],
      );
    });
  }
}