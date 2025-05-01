class ScrapedArticleEntity {
  final String articleUrl;
  final String htmlContent;
  final DateTime scrapedAt;

  ScrapedArticleEntity({
    required this.articleUrl,
    required this.htmlContent,
    required this.scrapedAt,
  });
}