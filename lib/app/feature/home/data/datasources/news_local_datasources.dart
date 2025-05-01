import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entities/scraped_article_entity.dart';
import '../models/news_model.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheNews(NewsModel newsModel);
  Future<NewsModel> getCachedNews();
  Future<void> cacheScrapedArticle(ScrapedArticleEntity scrapedArticle);
  Future<ScrapedArticleEntity?> getCachedScrapedArticle(String url);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {

  static const String _newsBox = 'newsBox';
  static const String _cacheKey = 'newsData';
  static const String _scrapedArticlesBox = 'scrapedArticles';

  // static void registerAdapters() {
  //   Hive.registerAdapter(ScrapedArticleEntityAdapter());
  // }

  @override
  Future<void> cacheNews(NewsModel newsModel) async {
    final box = await Hive.openBox(_newsBox);
    await box.put(_cacheKey, jsonEncode(newsModel.toJson()));
  }

  @override
  Future<NewsModel> getCachedNews() async {
    final box = await Hive.openBox(_newsBox);
    final jsonString = box.get(_cacheKey);
    if (jsonString != null) {
      return NewsModel.fromJson(jsonDecode(jsonString));
    }
    return NewsModel(articles: []);
  }
  @override
  Future<void> cacheScrapedArticle(ScrapedArticleEntity article) async {
    final box = await Hive.openBox<ScrapedArticleEntity>(_scrapedArticlesBox);
    await box.put(article.articleUrl, article); // Store by URL as key
  }

  @override
  Future<ScrapedArticleEntity?> getCachedScrapedArticle(String url) async {
    final box = await Hive.openBox<ScrapedArticleEntity>(_scrapedArticlesBox);
    return box.get(url); // Retrieve by URL
  }
}
