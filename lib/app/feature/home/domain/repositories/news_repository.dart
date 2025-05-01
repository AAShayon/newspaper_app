import 'package:dartz/dartz.dart';
import 'package:newspaper_app/app/feature/home/domain/entities/news_entity.dart';

import '../entities/scraped_article_entity.dart';


abstract class NewsRepository {
  Future<Either<String, NewsEntity>> getTopHeadlines();
  Future<Either<String, ScrapedArticleEntity>> getArticleContent(String url);
}