import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/router/all_routes.dart';
import '../../../auth/presentation/controllers/auth_controller.dart';

class InitialLoader extends StatefulWidget {
  final AuthController _authController = Get.find(); // Get instance of AuthController

  InitialLoader({super.key});

  @override
  State<InitialLoader> createState() => _InitialLoaderState();
}

class _InitialLoaderState extends State<InitialLoader> {
  double _progress = 0.0; // Progress value (0.0 to 1.0)
  bool _isLoadingComplete = false; // Tracks if loading is complete

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  // Simulate loading progress
  Future<void> _simulateLoading() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 20)); // Increment every 20ms
      setState(() {
        _progress = i / 100; // Update progress (0.0 to 1.0)
      });
    }

    // Check login state after progress reaches 100%
    final isLoggedIn = await widget._authController.isUserLoggedIn();

    setState(() {
      _isLoadingComplete = true;
    });


    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isLoggedIn) {
        Get.offAllNamed(AppPages.home); // Navigate to Home Screen
      } else {
        Get.offAllNamed(AppPages.login); // Navigate to Login Screen
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo or Icon
              Image.asset(
                'assets/images/splashIcon.png', // Replace with your app logo
                height: 100,
                width: 100,
              ),
              const SizedBox(height: 32),

              // Progress Bar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: _progress, // Progress value (0.0 to 1.0)
                  minHeight: 8,
                  backgroundColor: Colors.grey[300],
                  color: Theme.of(context).primaryColor,
                ),
              ),
              const SizedBox(height: 16),

              // Progress Percentage Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${(_progress * 100).toInt()}%', // Display progress percentage
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedOpacity(
                    opacity: _isLoadingComplete ? 1 : 0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 24,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Loading Message
              Text(
                _isLoadingComplete ? 'Redirecting...' : 'Checking authentication...',
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyMedium?.color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}