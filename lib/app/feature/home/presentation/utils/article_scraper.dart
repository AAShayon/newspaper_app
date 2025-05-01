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