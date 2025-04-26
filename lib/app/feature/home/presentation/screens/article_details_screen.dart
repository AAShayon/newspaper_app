import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import '../../domain/entities/article_entities.dart';



class ArticleDetailsScreen extends StatelessWidget {
  final ArticleEntity article = Get.arguments;

  ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Details"),
        backgroundColor: AppColor.primaryColor(context),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage.isNotEmpty)
              Image.network(
                article.urlToImage,
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 16.h),
            Text(
              article.title,
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: AppColor.textColor(context)),
            ),
            SizedBox(height: 8.h),
            Text(
              article.description,
              style: TextStyle(fontSize: 16.sp, color: AppColor.secondaryTextColor(context)),
            ),
            SizedBox(height: 16.h),
            Text(
              article.publishedAt,
              style: TextStyle(fontSize: 14.sp, color: AppColor.secondaryTextColor(context)),
            ),
            SizedBox(height: 16.h),
            Text(
              article.url,
              style: TextStyle(fontSize: 14.sp, color: AppColor.linkColor(context), decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }
}