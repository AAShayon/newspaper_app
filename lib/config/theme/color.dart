import 'package:flutter/material.dart';

class AppColor {
  // Private Constructor
  AppColor._();

  // Gradients
  static const LinearGradient softGradient = LinearGradient(
    colors: [
      Color(0xFFA8C0FF), // Light blue
      Color(0xFF3F63F6), // Blue accent
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [
      Color(0xFF1E1E2F), // Dark primary
      Color(0xFF394867), // Softer blue accent
      Color(0xFF4E6A8F), // Bright accent
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Colors
  static Color background(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E2F) // Dark background
        : const Color(0xFFFFFFFF); // Light background
  }

  static Color primaryColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF394867) // Dark primary
        : const Color(0xFF3F63F6); // Light primary
  }

  static Color textColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFFFFFFF) // Light text for dark mode
        : const Color(0xFF000000); // Dark text for light mode
  }

  static Color borderColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF4E6A8F) // Dark border
        : const Color(0xFFB0B0B0); // Light border
  }

  static Color fillColorTextFromField(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF394867) // Dark fill color
        : const Color(0xFFF0F0F0); // Light fill color
  }

  static Color iconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF4E6A8F) // Dark icon color
        : const Color(0xFF3F63F6); // Light icon color
  }

  static Color buttonColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF4E6A8F) // Dark button color
        : const Color(0xFF3F63F6); // Light button color
  }

  static Color richTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFFB0B0B0) // Light gray for dark mode
        : const Color(0xFF4E4E4E); // Darker gray for light mode
  }

  static LinearGradient gradient(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? darkGradient
        : softGradient;
  }
}