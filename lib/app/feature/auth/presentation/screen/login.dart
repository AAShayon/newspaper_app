import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/all_routes.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';

import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_font_style.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/divider_with_text.dart';
import '../controllers/auth_controller.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Get the AuthController instance
  final AuthController _authController = Get.find<AuthController>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 96.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // App Logo
            Image.asset(
              'assets/images/splashIcon.png',
              height: 100.h, // Responsive height
            ),
            SizedBox(height: 8.h), // Responsive spacing
            Align(
              alignment: Alignment.center,
              child: TextFontStyle.myAppText(
                context,
                'Stay informed with the latest news',
                style: TextStyleType.small,
                color: AppColor.richTextColor(context),
              ),
            ),
            SizedBox(height: 24.h),

            // Sign in with Google Button
            CustomButton(
              text: 'Sign in with Google',
              onPressed: _authController.handleGoogleSignIn,
              backgroundColor: AppColor.fillColorTextFromField(context),
              textColor: AppColor.textColor(context),
              icon: Image.asset(
                'assets/images/google.png',
                height: 20.h,
              ),
            ),
            SizedBox(height: 16.h),

            // Divider with "OR"
            DividerWithText(text: 'OR'),
            SizedBox(height: 16.h),

            // Email TextField
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              controller: _emailController,
            ),
            SizedBox(height: 16.h),

            // Password TextField
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter your password',
              // obscureText: true,
              controller: _passwordController,
              suffixIcon: IconButton(
                icon: Icon(Icons.visibility, color: AppColor.iconColor(context)),
                onPressed: () {

                },
              ),
            ),
            SizedBox(height: 16.h),

            // Sign In Button
            CustomButton(
              text: 'Sign In',
              onPressed: () {
                _authController.handleEmailSignIn(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );
              },
              backgroundColor: AppColor.primaryColor(context),
              textColor: Colors.white,
            ),
            SizedBox(height: 8.h),

            // Forgot Password Link
            TextButton(
              onPressed: () {
                // Navigate to Forgot Password Screen
              },
              child: TextFontStyle.myAppText(
                context,
                'Forgot Password?',
                style: TextStyleType.small,
                color: AppColor.primaryColor(context),
              ),
            ),

            // Sign Up Link
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFontStyle.myAppText(
                  context,
                  "Don't have an account? ",
                  style: TextStyleType.small,
                  color: AppColor.richTextColor(context),
                ),
                TextButton(
                  onPressed: () {
                  NavigationService.navigateTo(AppPages.registration);
                  },
                  child: TextFontStyle.myAppText(
                    context,
                    'Sign Up',
                    style: TextStyleType.small,
                    color: AppColor.primaryColor(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}