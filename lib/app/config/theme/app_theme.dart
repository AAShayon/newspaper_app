import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

class AppTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColor.primaryColor(context),
    textTheme: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme.apply(
        bodyColor: AppColor.textColor(context),
        displayColor: AppColor.textColor(context),
      ),
    ),
    scaffoldBackgroundColor: AppColor.background(context),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primaryColor(context),
      iconTheme: IconThemeData(color: AppColor.textColor(context)),
      titleTextStyle: TextStyle(
        color: AppColor.textColor(context),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.fillColorTextFromField(context),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.borderColor(context),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonColor(context),
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: IconThemeData(
      color: AppColor.iconColor(context),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColor.primaryColor(context),
      onPrimary: Colors.white,
      secondary: Colors.blueAccent,
      onSecondary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: AppColor.background(context),
      onBackground: AppColor.textColor(context),
      surface: Colors.white,
      onSurface: AppColor.textColor(context),
    ),
  );

  static ThemeData darkTheme(BuildContext context) => ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColor.primaryColor(context),
    textTheme: GoogleFonts.robotoTextTheme(
      Theme.of(context).textTheme.apply(
        bodyColor: AppColor.textColor(context),
        displayColor: AppColor.textColor(context),
      ),
    ),
    scaffoldBackgroundColor: AppColor.background(context),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColor.primaryColor(context),
      iconTheme: IconThemeData(color: AppColor.textColor(context)),
      titleTextStyle: TextStyle(
        color: AppColor.textColor(context),
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColor.fillColorTextFromField(context),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColor.borderColor(context),
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColor.buttonColor(context),
      textTheme: ButtonTextTheme.primary,
    ),
    iconTheme: IconThemeData(
      color: AppColor.iconColor(context),
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: AppColor.primaryColor(context),
      onPrimary: Colors.black,
      secondary: Colors.blueGrey,
      onSecondary: Colors.black,
      error: Colors.redAccent,
      onError: Colors.black,
      background: AppColor.background(context),
      onBackground: AppColor.textColor(context),
      surface: AppColor.background(context),
      onSurface: AppColor.textColor(context),
    ),
  );
}