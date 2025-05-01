// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
// import 'package:html/parser.dart' show parse;
// import 'package:newspaper_app/app/config/theme/color.dart';
//
// import '../../../../core/network/api_client.dart';
//
// class ArticleScraper {
//   final Dio _dio;
//   final ApiClient apiClient;
//
//   ArticleScraper()
//       : _dio = Dio(),
//         apiClient = ApiClient(Dio());
//
//   Future<Widget?> scrapeArticleContent(
//     String articleUrl, {
//     String? titleToRemove,
//     required double fontSize,
//   }) async {
//     try {
//       final response = await apiClient.getRawResponse(articleUrl);
//       if (response?.statusCode == 200 && response!.data is String) {
//         return _extractArticleContent(
//           response.data as String,
//           titleToRemove: "$titleToRemove",
//           fontSize: fontSize,
//         );
//       } else {
//         debugPrint(
//             "Failed to load article page: ${response?.statusCode ?? 'Unknown'}");
//         return null;
//       }
//     } catch (e) {
//       debugPrint("Error fetching article content: $e");
//       return null;
//     }
//   }
//
//   Widget _extractArticleContent(
//     String html, {
//     required String titleToRemove,
//     required double fontSize,
//   }) {
//     final document = parse(html);
//
//     final articleElement = document.querySelector('article') ??
//         document.querySelector('div.content') ??
//         document.querySelector('div.article-body') ??
//         document.querySelector('main') ??
//         document.body;
//
//     if (articleElement != null) {
//       // Remove elements with title text match (ignoring case and trimming)
//       final possibleTitleTags =
//           articleElement.querySelectorAll('h1, h2, h3, p, div');
//       for (final tag in possibleTitleTags) {
//         final tagText = tag.text.trim().toLowerCase();
//         final titleToCompare = titleToRemove.trim().toLowerCase();
//
//         // Check if the tag text contains the title (not just exact match)
//         if (tagText.contains(titleToCompare) ||
//             titleToCompare.contains(tagText)) {
//           tag.remove();
//           debugPrint("Removed duplicate title: ${tag.text}");
//           break;
//         }
//       }
//
//       // Also check for meta tags that might contain the title
//       final metaTags = document.querySelectorAll(
//           'meta[property="og:title"], meta[name="twitter:title"]');
//       for (final meta in metaTags) {
//         final content = meta.attributes['content']?.trim().toLowerCase() ?? '';
//         if (content.contains(titleToRemove.trim().toLowerCase())) {
//           meta.remove();
//           debugPrint("Removed meta title tag");
//         }
//       }
//
//       return HtmlWidget(
//         articleElement.outerHtml,
//         textStyle: TextStyle(
//           fontSize: fontSize,
//           color: AppColor.softBlueAccent,
//         ), // Default text size
//       );
//     } else {
//       return const Text("No article content found.");
//     }
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:html/parser.dart' show parse;
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/feature/home/domain/entities/scraped_article_entity.dart';

class ArticleScraperHelper {
  static Widget buildArticleWidget(
      ScrapedArticleEntity article, {
        String? titleToRemove,
        required double fontSize,
      }) {
    final document = parse(article.htmlContent);

    final articleElement = document.querySelector('article') ??
        document.querySelector('div.content') ??
        document.querySelector('div.article-body') ??
        document.querySelector('main') ??
        document.body;

    if (articleElement != null) {
      _removeDuplicateTitle(articleElement, titleToRemove);
      return _buildHtmlWidget(articleElement.outerHtml, fontSize);
    } else {
      return const Text("No article content found.");
    }
  }

  static void _removeDuplicateTitle(dynamic articleElement, String? titleToRemove) {
    if (titleToRemove == null) return;

    final possibleTitleTags = articleElement.querySelectorAll('h1, h2, h3, p, div');
    for (final tag in possibleTitleTags) {
      final tagText = tag.text.trim().toLowerCase();
      final titleToCompare = titleToRemove.trim().toLowerCase();

      if (tagText.contains(titleToCompare) || titleToCompare.contains(tagText)) {
        tag.remove();
        break;
      }
    }

    final metaTags = articleElement.querySelectorAll(
      'meta[property="og:title"], meta[name="twitter:title"]',
    );
    for (final meta in metaTags) {
      final content = meta.attributes['content']?.trim().toLowerCase() ?? '';
      if (content.contains(titleToRemove.trim().toLowerCase())) {
        meta.remove();
      }
    }
  }

  static Widget _buildHtmlWidget(String html, double fontSize) {
    return HtmlWidget(
      html,
      textStyle: TextStyle(
        fontSize: fontSize,
        color: AppColor.softBlueAccent,
      ),
    );
  }
}