import 'article_model.dart';

class NewsModel {
  final List<ArticleModel> articles;

  NewsModel({required this.articles});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> articlesJson = json['articles'];
    final articles =
    articlesJson.map((article) => ArticleModel.fromJson(article)).toList();
    return NewsModel(articles: articles);
  }

  Map<String, dynamic> toJson() {
    return {
      'articles': articles.map((article) => article.toJson()).toList(),
    };
  }
}