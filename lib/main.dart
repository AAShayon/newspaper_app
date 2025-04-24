import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/config/theme/app_theme.dart';
import 'app/core/utils/helper/helper_methods.dart';
import 'app/feature/auth/presentation/screen/login.dart';


void main() {
  runApp(const NewspaperApp());
}

class NewspaperApp extends StatelessWidget {
  const NewspaperApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return DismissKeyboard(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Newspaper App',
            theme: AppTheme.lightTheme(context),
            darkTheme: AppTheme.darkTheme(context),
            themeMode: ThemeMode.system,
            home: child,
          ),
        );
      },
      child: const LoginScreen(),
    );
  }
}