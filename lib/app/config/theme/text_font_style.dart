import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

enum TextStyleType { small, medium, large }

class TextFontStyle {
  TextFontStyle._();

  // Fixed font sizes for mobile
  static double fontSizeSmall = 12.sp;
  static double fontSizeMedium = 15.sp;
  static double fontSizeLarge = 18.sp;

  // Styles for different text types
  static TextStyle smallText(BuildContext context) => _getTextStyle(
        context,
        fontSizeSmall,
        FontWeight.normal,
      );

  static TextStyle mediumText(BuildContext context) => _getTextStyle(
        context,
        fontSizeMedium,
        FontWeight.normal,
      );

  static TextStyle largeText(BuildContext context) => _getTextStyle(
        context,
        fontSizeLarge,
        FontWeight.bold,
      );

  // Helper method to create text styles
  static TextStyle _getTextStyle(
    BuildContext context,
    double fontSize,
    FontWeight fontWeight,
  ) {
    return GoogleFonts.roboto(
      color: AppColor.textColor(context),
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  // Helper Widget for Text with Dynamic Style
  static Widget myAppText(
    BuildContext context,
    String text, {
    TextStyleType style = TextStyleType.medium,
    Color? color,
    double? textSize,
    String fontFamily = "Roboto",
    FontWeight fontWeight = FontWeight.normal,
  }) {
    final TextStyle baseStyle;
    switch (style) {
      case TextStyleType.small:
        baseStyle = smallText(context);
        break;
      case TextStyleType.large:
        baseStyle = largeText(context);
        break;
      case TextStyleType.medium:
        baseStyle = mediumText(context);
        break;
    }

    return Text(
      text,
      style: baseStyle.copyWith(
        color: color,
        fontSize: textSize,
        fontFamily: fontFamily,
        fontWeight: fontWeight,
      ),
    );
  }
}
