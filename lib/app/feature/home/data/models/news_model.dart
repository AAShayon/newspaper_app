import 'article_model.dart';

class NewsModel {
  final List<ArticleModel> articles;

  NewsModel({required this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw Exception('Invalid JSON data for NewsModel');
    }

    return NewsModel(
      articles: (json['articles'] as List<dynamic>?)
          ?.map((article) => ArticleModel.fromJson(article))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}