import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newspaper_app/feature/auth/presentation/login.dart';

import 'config/theme/app_theme.dart';

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
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Newspaper App',
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          themeMode: ThemeMode.system,
          home: child,
        );
      },
      child: const LoginPage(),
    );
  }
}