import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../config/theme/color.dart';
import '../../../../config/theme/text_font_style.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/divider_with_text.dart';
import '../controllers/auth_controller.dart';


class RegisterScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Get the AuthController instance
  final AuthController _authController = Get.find<AuthController>();

  RegisterScreen({super.key});

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
                'Create your account',
                style: TextStyleType.large,
                color: AppColor.richTextColor(context),
              ),
            ),
            SizedBox(height: 24.h),

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
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 16.h),

            // Confirm Password TextField
            CustomTextField(
              labelText: 'Confirm Password',
              hintText: 'Re-enter your password',
              obscureText: true,
              controller: _confirmPasswordController,
            ),
            SizedBox(height: 24.h),

            // Register Button
            CustomButton(
              text: 'Register',
              onPressed: () {
                if (_passwordController.text == _confirmPasswordController.text) {
                  _authController.handleEmailRegister(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                } else {
                  Get.snackbar('Error', 'Passwords do not match');
                }
              },
              backgroundColor: AppColor.primaryColor(context),
              textColor: Colors.white,
            ),
            SizedBox(height: 16.h),

            // Divider with "OR"
            const DividerWithText(text: 'OR'),
            SizedBox(height: 16.h),

            // Sign up with Google Button
            CustomButton(
              text: 'Sign up with Google',
              onPressed: _authController.handleGoogleSignIn,
              backgroundColor: AppColor.fillColorTextFromField(context),
              textColor: AppColor.textColor(context),
              icon: Image.asset(
                'assets/images/google.png',
                height: 20.h,
              ),
            ),
            SizedBox(height: 16.h),

            // Already have an account? Sign In
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFontStyle.myAppText(
                  context,
                  "Already have an account? ",
                  style: TextStyleType.small,
                  color: AppColor.richTextColor(context),
                ),
                TextButton(
                  onPressed: () {
                    Get.back(); // Navigate back to Login Screen
                  },
                  child: TextFontStyle.myAppText(
                    context,
                    'Sign In',
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