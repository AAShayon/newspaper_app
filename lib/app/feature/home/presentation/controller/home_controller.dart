import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/article_entities.dart';
import '../../domain/entities/scraped_article_entity.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/scrape_article.dart';

class HomeController extends GetxController {
  final GetTopHeadlines getTopHeadlines;
  final GetCachedArticle getCachedArticle;

  HomeController({
    required this.getTopHeadlines,
    required this.getCachedArticle,
  });

  RxList<ArticleEntity> articles = <ArticleEntity>[].obs;
  RxBool isLoading = true.obs;
  RxDouble textSizeFactor = 1.0.obs; // For font size scaling
  Rx<ScrapedArticleEntity?> currentArticle = Rx<ScrapedArticleEntity?>(null);
  RxString articleError = ''.obs;
  RxString currentArticleTitle = ''.obs;
  final RxList<String> readLaterArticles = <String>[].obs;

  // Fetch top headlines
  Future<void> fetchTopHeadlines() async {
    isLoading.value = true;
    articleError.value = '';
    final result = await getTopHeadlines.call();
    result.fold(
          (failure) => articleError.value = failure,
          (newsEntity) => articles.assignAll(newsEntity.articles),
    );
    isLoading.value = false;
  }
  // // Toggle article in read later list
  // Future<void> toggleReadLater(String articleUrl) async {
  //   final box = await Hive.openBox('read_later_articles');
  //
  //   if (readLaterArticles.contains(articleUrl)) {
  //     readLaterArticles.add(articleUrl);
  //     await box.put('articles', readLaterArticles.toList());
  //     await saveArticleForLater(articleUrl);
  //     Get.snackbar(backgroundColor: Colors.grey,'Success', 'Added to Read Later');
  //
  //   } else {
  //     log("Before removal: $readLaterArticles");
  //     readLaterArticles.remove(articleUrl);
  //     log("After removal: $readLaterArticles");
  //
  //     await box.put('articles', readLaterArticles.toList());
  //
  //     Get.snackbar(backgroundColor: Colors.grey,'Success', 'Removed from Read Later');
  //   }
  // }
  Future<void> toggleReadLater(String articleUrl) async {
    final box = await Hive.openBox('read_later_articles');

    if (readLaterArticles.contains(articleUrl)) {
      readLaterArticles.remove(articleUrl);
      Get.snackbar(
        backgroundColor: Colors.grey,
        'Success',
        'Removed from Read Later',
      );
    } else {
      readLaterArticles.add(articleUrl);
      Get.snackbar(
        backgroundColor: Colors.grey,
        'Success',
        'Added to Read Later',
      );
    }

    await box.put('articles', readLaterArticles);
  }

  Future<void> saveArticleForLater(String url) async {
    // This will trigger scraping only once
    final result = await getCachedArticle.call(url);
    result.fold(
          (failure) {
        Get.snackbar('Error', failure);
      },
          (scrapedArticle) {
        Get.snackbar('Success', 'Article saved for later reading.');
      },
    );
  }

  Future<void> loadArticleContent(String url) async {
    isLoading.value = true;
    articleError.value = '';
    currentArticle.value = null;

    final result = await getCachedArticle.call(url);
    result.fold(
          (failure) => articleError.value = failure,
          (scrapedArticle) => currentArticle.value = scrapedArticle,
    );

    isLoading.value = false;
  }

  // Update text size preference
  void updateTextSize(double factor) {
    textSizeFactor.value = factor;
  }

  // Get current font size based on factor
  double getCurrentFontSize() {
    return 16.0 * textSizeFactor.value; // Base size 16, scaled by factor
  }

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }
}