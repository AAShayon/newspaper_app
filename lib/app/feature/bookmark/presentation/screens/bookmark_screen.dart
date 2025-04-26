import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkScreen extends StatelessWidget {
  final BookmarkController controller = Get.find<BookmarkController>();

    BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmarks"),
      ),
      body: Obx(() {
        if (controller.bookmarks.isEmpty) {
          return Center(child: Text("No bookmarks found"));
        } else {
          return ListView.builder(
            itemCount: controller.bookmarks.length,
            itemBuilder: (context, index) {
              final article = controller.bookmarks[index];
              return ListTile(
                title: Text(article['title']),
                subtitle: Text(article['description']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Remove from bookmarks
                    controller.toggleBookmark('current_user_id', article);
                  },
                ),
              );
            },
          );
        }
      }),
    );
  }
}