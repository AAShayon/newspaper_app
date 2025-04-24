import 'package:flutter/material.dart';
import '../../config/theme/color.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
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
        suffixIcon: suffixIcon,
      ),
    );
  }
}