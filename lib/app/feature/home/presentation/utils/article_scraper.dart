import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:html/parser.dart' show Parser, parse;

class ArticleScraper {
  final Dio _dio = Dio();

  Future<String?> scrapeArticleContent(String articleUrl) async {
    try {
      final response = await _dio.get(articleUrl);
      if (response.statusCode == 200) {
        return _extractArticleContent(response.data as String);
      } else {
        log("Failed to load article page: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      log("Error fetching article content: $e");
      return null;
    }
  }

  String? _extractArticleContent(String html) {
    final document = parse(html);
    final articleElement = document.querySelector('article') ??
        document.querySelector('div.content') ??
        document.querySelector('div.article-body') ??
        document.querySelector('main');

    if (articleElement != null) {
      return articleElement.text.trim();
    } else {
      return null;
    }
  }
}