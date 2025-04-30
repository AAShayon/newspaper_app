import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newspaper_app/app/config/theme/color.dart';

class ArticleContent extends StatelessWidget {
  final bool isLoading;
  final Widget? fullArticleContent;
  final String articleContent;
  final double textSizeFactor;

  const ArticleContent({
    super.key,
    required this.isLoading,
    this.fullArticleContent,
    required this.articleContent,
    required this.textSizeFactor,
  });

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : fullArticleContent != null
        ? fullArticleContent!
        : Column(
      children: [
        Text(
          articleContent
              .replaceAll(RegExp(r'\[\+\d+ chars\]'), '')
              .trim() +
              (RegExp(r'\[\+\d+ chars\]').hasMatch(articleContent)
                  ? " Could not load full article content....."
                  : ''),
          style: TextStyle(
            fontSize: 16.sp * textSizeFactor,
            color: AppColor.textColor(context),
          ),
        ),
      ],
    );
  }
}