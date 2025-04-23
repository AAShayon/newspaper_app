import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../config/theme/color.dart';
import '../../../config/theme/text_font_style.dart';


class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
            ElevatedButton.icon(
              onPressed: () {},
              icon: Image.asset(
                'assets/images/google.png',
                height: 20.h, // Responsive height
              ),
              label: TextFontStyle.myAppText(
                context,
                'Sign in with Google',
                style: TextStyleType.medium,
                color: AppColor.textColor(context),
              ),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColor.textColor(context),
                backgroundColor: AppColor.fillColorTextFromField(context),
                side: BorderSide(color: AppColor.primaryColor(context), width: 1.0),
                padding: EdgeInsets.symmetric(vertical: 12.h), // Responsive padding
              ),
            ),
            SizedBox(height: 16.h),

            // Divider with "OR" text
            Row(
              children: [
                Expanded(child: Divider(color: AppColor.borderColor(context))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: TextFontStyle.myAppText(
                    context,
                    'OR',
                    style: TextStyleType.small,
                    color: AppColor.richTextColor(context),
                  ),
                ),
                Expanded(child: Divider(color: AppColor.borderColor(context))),
              ],
            ),
            SizedBox(height: 16.h),

            // Email TextField
            TextField(
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                labelStyle: TextStyle(color: AppColor.textColor(context)),
                hintStyle: TextStyle(color: AppColor.richTextColor(context)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.borderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.borderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor(context)),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Password TextField
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                labelStyle: TextStyle(color: AppColor.textColor(context)),
                hintStyle: TextStyle(color: AppColor.richTextColor(context)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.borderColor(context)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.borderColor(context)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: AppColor.primaryColor(context)),
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility, color: AppColor.iconColor(context)),
                  onPressed: () {
                    // Add toggle logic here
                  },
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Sign In Button
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor(context),
                padding: EdgeInsets.symmetric(vertical: 12.h), // Responsive padding
              ),
              child: TextFontStyle.myAppText(
                context,
                'Sign In',
                style: TextStyleType.medium,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.h),

            // Forgot Password Link
            TextButton(
              onPressed: () {},
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
                  onPressed: () {},
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