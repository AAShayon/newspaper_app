import 'package:flutter/material.dart';

class AppColor {
  // Private Constructor
  AppColor._();

  // ========== Base Colors ==========
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color lightBlue = Color(0xFFA8C0FF);
  static const Color blueAccent = Color(0xFF3F63F6);
  static const Color darkPrimary = Color(0xFF1E1E2F);
  static const Color softBlueAccent = Color(0xFF394867);
  static const Color brightAccent = Color(0xFF4E6A8F);
  static const Color lightGray = Color(0xFFB0B0B0);
  static const Color inputFillLight = Color(0xFFF0F0F0);
  static const Color richTextLight = Color(0xFF4E4E4E);

  // ========== Gradients ==========
  static const LinearGradient softGradient = LinearGradient(
    colors: [lightBlue, blueAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [darkPrimary, softBlueAccent, brightAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ========== Themed Color Getters ==========
  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkPrimary : white;

  static Color primaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? softBlueAccent : blueAccent;

  static Color textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? white : black;

  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? brightAccent : lightGray;

  static Color fillColorTextFromField(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? softBlueAccent : inputFillLight;

  static Color iconColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? brightAccent : blueAccent;

  static Color buttonColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? brightAccent : blueAccent;

  static Color richTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? lightGray : richTextLight;

  static LinearGradient gradient(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkGradient : softGradient;
}
