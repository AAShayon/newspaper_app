import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newspaper_app/app/config/theme/color.dart';

class ArticleTitle extends StatelessWidget {
  final String title;
  final double textSizeFactor;

  const ArticleTitle({super.key, required this.title, required this.textSizeFactor});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 24.sp * textSizeFactor,
        color: AppColor.softBlueAccent,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}