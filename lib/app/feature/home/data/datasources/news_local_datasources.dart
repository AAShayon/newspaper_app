import 'dart:convert';
import 'package:hive/hive.dart';
import '../../domain/entities/scraped_article_entity.dart';
import '../models/news_model.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheNews(NewsModel newsModel);
  Future<NewsModel> getCachedNews();
  Future<void> cacheScrapedArticle(ScrapedArticleEntity article);
  Future<ScrapedArticleEntity> getCachedScrapedArticle(String url);
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {

  static const String _newsBox = 'newsBox';
  static const String _cacheKey = 'newsData';
  static const String _scrapedArticlesBox = 'scrapedArticlesBox';
  static const String _scrapedArticlesKey = 'scrapedArticles';

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
    final box = await Hive.openBox(_scrapedArticlesBox);
    final cachedArticles = box.get(_scrapedArticlesKey, defaultValue: {}) as Map;
    cachedArticles[article.articleUrl] = {
      'htmlContent': article.htmlContent,
      'scrapedAt': article.scrapedAt.toIso8601String(),
    };
    await box.put(_scrapedArticlesKey, cachedArticles);
  }

  @override
  Future<ScrapedArticleEntity> getCachedScrapedArticle(String url) async {
    final box = await Hive.openBox(_scrapedArticlesBox);
    final cachedArticles = box.get(_scrapedArticlesKey, defaultValue: {}) as Map;
    final articleData = cachedArticles[url] as Map<String, dynamic>?;

    if (articleData != null) {
      return ScrapedArticleEntity(
        articleUrl: url,
        htmlContent: articleData['htmlContent'],
        scrapedAt: DateTime.parse(articleData['scrapedAt']),
      );
    }
    throw Exception('Article not found in cache');
  }
}
