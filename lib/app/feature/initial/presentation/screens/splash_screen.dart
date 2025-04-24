import 'package:flutter/material.dart';
import 'package:animated_splash_plus/animated_splash_plus.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/theme/color.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashPlus(
      config:  SplashConfig(
        appName: 'Newspaper App',
        appNamePart1: 'News',
        appNamePart2: 'Paper',
        subtitle: 'Stay informed with the latest news',
        welcomeText: 'Welcome',
        sunsetDuration: Duration(seconds: 3), // Duration of the splash animation
        textAnimationDuration: Duration(seconds: 2), // Duration of text animations
        sunStartColor: Colors.blue, // Start color of the sun animation
        sunEndColor: Colors.red, // End color of the sun animation
        skyEndBottomColor: AppColor.primaryColor(context),
        skyEndMiddleColor: AppColor.primaryColor(context),
        skyEndTopColor: AppColor.primaryColor(context),

      ),
      onAnimationComplete: () {
        // Navigate to the Initial Loader after the splash animation completes
        // Get.toNamed(AppPages.loading);
      },
    );
  }
}