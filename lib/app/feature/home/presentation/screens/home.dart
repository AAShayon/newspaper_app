import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/feature/home/presentation/widgets/drawer_widget.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        backgroundColor: AppColor.primaryColor(context),
      ),
      drawer: DrawerWidget(),
      body: Obx(() {
        if (homeController.isLoading.value) {
          // Show a loading indicator while fetching data
          return Center(child: CircularProgressIndicator());
        } else if (homeController.articles.isEmpty) {
          // Handle the case where no articles are available
          return Center(
            child: Text(
              "No articles found",
              style: TextStyle(fontSize: 18.sp, color: AppColor.textColor(context)),
            ),
          );
        } else {
          // Display the list of articles
          return ListView.builder(
            itemCount: homeController.articles.length,
            itemBuilder: (context, index) {
              final article = homeController.articles[index];
              return ListTile(
                leading: article.urlToImage.isNotEmpty
                    ? Image.network(
                  article.urlToImage,
                  width: 50.w,
                  height: 50.h,
                  fit: BoxFit.cover,
                )
                    : Icon(Icons.image_not_supported, size: 50.sp),
                title: Text(
                  article.title,
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: AppColor.textColor(context)),
                ),
                subtitle: Text(
                  article.description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14.sp, color: AppColor.secondaryTextColor(context)),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.bookmark_border, color: AppColor.iconColor(context)),
                  onPressed: () {
                    // Add bookmark logic here
                    Get.snackbar('Bookmark', 'Article bookmarked!');
                  },
                ),
                onTap: () {
                  // Navigate to the article details screen
                  Get.toNamed('/details', arguments: article);
                },
              );
            },
          );
        }
      }),
    );
  }
}