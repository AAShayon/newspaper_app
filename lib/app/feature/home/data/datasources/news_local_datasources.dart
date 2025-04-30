import 'dart:convert';
import 'package:hive/hive.dart';
import '../models/news_model.dart';

abstract class NewsLocalDataSource {
  Future<void> cacheNews(NewsModel newsModel);
  Future<NewsModel> getCachedNews();
}

class NewsLocalDataSourceImpl implements NewsLocalDataSource {

  static const String _newsBox = 'newsBox';
  static const String _cacheKey = 'newsData';

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
}
