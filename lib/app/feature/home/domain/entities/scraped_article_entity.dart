// lib/app/feature/home/domain/entities/scraped_article_entity.dart
import 'package:hive/hive.dart';

part 'scraped_article_entity.g.dart';

@HiveType(typeId: 0)
class ScrapedArticleEntity {
  @HiveField(0)
  final String articleUrl;

  @HiveField(1)
  final String htmlContent;

  @HiveField(2)
  final DateTime scrapedAt;

  ScrapedArticleEntity({
    required this.articleUrl,
    required this.htmlContent,
    required this.scrapedAt,
  });
}