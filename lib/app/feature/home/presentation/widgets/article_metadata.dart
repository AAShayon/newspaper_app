import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newspaper_app/app/config/theme/color.dart';

class ArticleMetadata extends StatelessWidget {
  final String author;
  final String publishedAt;
  final String? sourceName;
  final double textSizeFactor;

  const ArticleMetadata({
    super.key,
    required this.author,
    required this.publishedAt,
    required this.sourceName,
    required this.textSizeFactor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Author: $author",
          style: TextStyle(
            fontSize: 14.sp * textSizeFactor,
            color: AppColor.softBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "Published At: $publishedAt",
          style: TextStyle(
            fontSize: 14.sp * textSizeFactor,
            color: AppColor.softBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          "Source name: $sourceName",
          style: TextStyle(
            fontSize: 14.sp * textSizeFactor,
            color: AppColor.softBlueAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}