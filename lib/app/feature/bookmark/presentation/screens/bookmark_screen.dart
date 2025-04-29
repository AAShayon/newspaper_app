
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:newspaper_app/app/config/router/all_routes.dart';
import 'package:newspaper_app/app/config/router/navigation_service.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkScreen extends StatelessWidget {
  final BookmarkController controller = Get.find<BookmarkController>();

   BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Bookmarks")),
      body: Obx(() {
        if (controller.bookmarks.isEmpty) {
          return const Center(child: Text("No bookmarks found"));
        }

        return ListView.builder(
          itemCount: controller.bookmarks.length,
          itemBuilder: (context, index) {
            final article = controller.bookmarks[index];

            final String urlToImage = article['urlToImage'] ?? '';
            final String title = article['title'] ?? 'No Title';

            return Card(
              margin: const EdgeInsets.all(12),
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () {
                  // final ArticleEntity article = ArticleEntity.fromJson(articleMap);

                  // Navigate to Article Details Screen
                  NavigationService.navigateToWithObject(AppPages.details, article);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image
                    if (urlToImage.isNotEmpty)
                      CachedNetworkImage(
                        imageUrl: urlToImage,
                        height: 200.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 200.h,
                          color: Colors.grey[300],
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline, size: 40),
                      ),

                    // Headline
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),

                    // Bookmark Button
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.toggleBookmark(article);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}