import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:newspaper_app/app/feature/home/domain/entities/article_entities.dart';

import '../controller/home_controller.dart';

class ReadLaterButton extends StatelessWidget {
  final ArticleEntity article;
  final VoidCallback onSaved;
  final VoidCallback onRemoved;

  const ReadLaterButton({
    super.key,
    required this.article,
    required this.onSaved,
    required this.onRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final isReadLater = controller.readLaterArticles.contains(article.url);

      return IconButton(
        icon: FaIcon(
          FontAwesomeIcons.bookmark,
          color: isReadLater ? Colors.red : Colors.grey,
        ),
        onPressed: () => controller.toggleReadLater(article.url),
      );
    });
  }
}

// static const String readLaterBox = 'read_later_articles';
// Future<void> _toggleReadLater(ArticleEntity article, HomeController controller) async {
//   final box = await Hive.openBox(readLaterBox);
//   final savedArticles = box.get('articles', defaultValue: <ArticleEntity>[]) as List<ArticleEntity>;
//
//   final isAlreadySaved = savedArticles.any((a) => a.url == article.url);
//
//   if (!isAlreadySaved) {
//     savedArticles.add(article);
//     onSaved();
//   } else {
//     savedArticles.removeWhere((a) => a.url == article.url);
//     onRemoved();
//   }
//
//   await box.put('articles', savedArticles);
//
//   // If not already scraped, scrape now
//   if (!isAlreadySaved) {
//     await controller.saveArticleForLater(article.url);
//   }
// }
