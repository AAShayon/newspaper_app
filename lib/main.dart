import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/all_routes.dart';
import 'package:newspaper_app/app/feature/auth/presentation/bindings/auth_binding.dart';
import 'package:newspaper_app/app/feature/initial/presentation/screens/splash_screen.dart';

import 'app/config/firebase_configuration/firebase_config.dart';
import 'app/config/injection/di.dart';
import 'app/config/theme/app_theme.dart';
import 'app/core/utils/helper/helper_methods.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseConfig.initialize();
  setupLocator();
  initiateInternetChecker();
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
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Newspaper App',
          theme: AppTheme.lightTheme(context),
          darkTheme: AppTheme.darkTheme(context),
          themeMode: ThemeMode.system,
          home: child,
          getPages: AppPages.routes,
          initialBinding: AuthBinding(),
        );
      },
      child:  SplashScreen(),
    );
  }
}