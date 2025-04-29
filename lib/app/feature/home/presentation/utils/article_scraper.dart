import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as html; // Add prefix here

class ArticleScraper {
  final Dio _dio = Dio();

  Future<Widget?> scrapeArticleContent(String articleUrl) async {
    try {
      final response = await _dio.get(articleUrl);
      if (response.statusCode == 200 && response.data is String) {
        return _extractArticleContent(response.data as String);
      } else {
        debugPrint("Failed to load article page: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Error fetching article content: $e");
      return null;
    }
  }

  Widget _extractArticleContent(String html) {
    final document = parse(html);

    final articleElement = document.querySelector('article') ??
        document.querySelector('div.content') ??
        document.querySelector('div.article-body') ??
        document.querySelector('main');

    if (articleElement != null) {
      return HtmlWidget(
        articleElement.outerHtml,
      );
    } else {
      return Text("No article content found.");
    }
  }
}