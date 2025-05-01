import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/router/all_routes.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/feature/home/presentation/widgets/drawer_widget.dart';
import '../../../../core/utils/helper/helper_methods.dart';
import '../../../bookmark/presentation/controllers/bookmark_controller.dart';
import '../controller/home_controller.dart';
 class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
   @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final BookmarkController bookmarkController = Get.find<BookmarkController>();
     return WillPopScope(
      onWillPop: () => showExitConfirmationDialog(context),
      child: Scaffold(
        appBar: AppBar(
          title: Text("News App"),
          backgroundColor: AppColor.primaryColor(context),
        ),
        drawer: DrawerWidget(),
        body: Obx(() {
          if (homeController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else if (homeController.articles.isEmpty) {
            return Center(
              child: Text(
                "No articles found",
                style: TextStyle(fontSize: 18.sp, color: AppColor.textColor(context)),
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: ()async => homeController.fetchTopHeadlines(),
              child: GridView.builder(
                padding: EdgeInsets.all(16.w),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                  childAspectRatio: .66,
                ),
                itemCount: homeController.articles.length,
                itemBuilder: (context, index) {
                  final article = homeController.articles[index];
                   return GestureDetector(
                    onTap: () {
                      NavigationService.navigateToWithObject(AppPages.details, article);
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
                              child: CachedNetworkImage(
                                imageUrl: article.urlToImage ,
                                width: double.infinity,
                                fit: BoxFit.fitWidth,
                                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  article.title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.textColor(context),
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  article.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColor.secondaryTextColor(context),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Obx(() {
                               final isBookmarked = bookmarkController.isBookmarked(article.url);
                               return IconButton(
                                icon: Icon(
                                  isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  color: isBookmarked ? Colors.blue : AppColor.iconColor(context),
                                ),
                                onPressed: () {
                                  print("Toggling bookmark for article: ${article.url}");
                                  bookmarkController.toggleBookmark( article.toModel().toJson());
                                },
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }),
      ),
    );
  }
}