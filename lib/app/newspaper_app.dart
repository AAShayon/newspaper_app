import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/all_routes.dart';
import 'package:newspaper_app/app/feature/auth/presentation/bindings/auth_binding.dart';
import 'package:newspaper_app/app/feature/initial/presentation/screens/splash_screen.dart';
import 'config/theme/app_theme.dart';
import 'core/utils/helper/helper_methods.dart';


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
          child: Obx((){
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Newspaper App',
              theme: AppTheme.lightTheme(context),
              darkTheme: AppTheme.darkTheme(context),
              themeMode: AppTheme.currentTheme.value,
              home: child,
              initialRoute: AppPages.splash,
              getPages: AppPages.routes,
              initialBinding: AuthBinding(),
            );
          })
        );
      },
      child: SplashScreen(),
    );
  }
}
