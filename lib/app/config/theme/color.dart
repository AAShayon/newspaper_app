import 'package:flutter/material.dart';

class AppColor {
  // Private Constructor
  AppColor._();

  // ========== Base Colors ==========
  static const Color white = Color(0xFFFFFFFF);
  static const Color offWhite = Color(0xFFF5F5F5);
  static const Color darkPrimary = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);

  static const Color primaryBlue = Color(0xFF2196F3);
  static const Color accentOrange = Color(0xFFFF9800);
  static const Color accentTeal = Color(0xFF009688);

  static const Color darkBlue = Color(0xFF64B5F6);
  static const Color darkAccentGreen = Color(0xFFCDDC39);
  static const Color darkAccentPink = Color(0xFFFF4081);
  static const Color lightGreyBlue = Color(0xFFE6ECF3);

  static const Color primaryTextLight = Color(0xFF212121);
  static const Color secondaryTextLight = Color(0xFF757575);
  static const Color primaryTextDark = Color(0xFFFFFFFF);
  static const Color secondaryTextDark = Color(0xFFBDBDBD);



  static const Color dividerLight = Color(0xFFE0E0E0);
  static const Color dividerDark = Color(0xFF333333);

  static const Color richTextLight = Color(0xFF4E4E4E);
  static const Color inputFillLight = Color(0xFFF0F0F0);
  static const Color softBlueAccent = Color(0xFF394867);

  static Color background(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkPrimary : offWhite;
  static Color drawerBackground(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? softBlueAccent : lightGreyBlue;

  static Color primaryColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBlue : primaryBlue;

  static Color textColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? primaryTextDark : primaryTextLight;

  static Color secondaryTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? secondaryTextDark : secondaryTextLight;

  static Color borderColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dividerDark : dividerLight;

  static Color fillColorTextField(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkSurface : inputFillLight;

  static Color iconColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkBlue : primaryBlue;

  static Color buttonColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkAccentGreen : accentOrange;
  static Color fillColorTextFromField(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? softBlueAccent : inputFillLight;

  static Color bookmarkColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? darkAccentPink : accentTeal;

  static Color richTextColor(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? secondaryTextDark : richTextLight;

  static LinearGradient gradient(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark
          ? LinearGradient(
        colors: [darkPrimary, darkSurface],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      )
          : LinearGradient(
        colors: [primaryBlue, accentTeal],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

}