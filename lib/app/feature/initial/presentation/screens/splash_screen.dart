import 'package:flutter/material.dart';
import 'package:animated_splash_plus/animated_splash_plus.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/feature/auth/presentation/controllers/auth_controller.dart';
import '../../../../config/router/all_routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    return AnimatedSplashPlus(
      config: SplashConfig(
        sunImage: AssetImage('assets/images/splashIcon.png'),
        appName: 'Newspaper App',
        appNamePart1: 'News',
        appNamePart2: 'Paper',
        subtitle: 'Stay informed with the latest news',
        welcomeText: 'Welcome',
        sunsetDuration: const Duration(seconds: 3), // Duration of the splash animation
        textAnimationDuration: const Duration(seconds: 2), // Duration of text animations
        sunStartColor: Colors.blue, // Start color of the sun animation
        sunEndColor: Colors.red, // End color of the sun animation
        skyEndBottomColor: AppColor.primaryColor(context),
        skyEndMiddleColor: AppColor.primaryColor(context),
        skyEndTopColor: AppColor.primaryColor(context),
      ),
      onAnimationComplete: () async {
        try {
          // Show a temporary loading indicator while checking login state
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );

          // Check login state
          final isLoggedIn = await authController.isUserLoggedIn();

          // Close the loading dialog
          if (context.mounted) Navigator.of(context).pop();

          // Navigate based on login state
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (isLoggedIn) {
              NavigationService.navigateToUntilReplacement(AppPages.home);
            } else {
              NavigationService.navigateToUntilReplacement(AppPages.login);
            }
          });
        } catch (e) {
          // Handle errors (e.g., show an error dialog)
          if (context.mounted) {
            Navigator.of(context).pop(); // Close any open dialogs
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: Text('Failed to load app data: $e'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        }
      },
    );
  }
}