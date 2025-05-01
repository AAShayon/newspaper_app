import 'package:dartz/dartz.dart';

import '../entities/scraped_article_entity.dart';
import '../repositories/news_repository.dart';

class GetCachedArticle {
  final NewsRepository repository;

  GetCachedArticle(this.repository);

  Future<Either<String, ScrapedArticleEntity>> call(String url) async {
    return await repository.getArticleContent(url);
  }
}