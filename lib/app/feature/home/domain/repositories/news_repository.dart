import 'package:dartz/dartz.dart';
import 'package:newspaper_app/app/feature/home/domain/entities/news_entity.dart';


abstract class NewsRepository {
  Future<Either<String, NewsEntity>> getTopHeadlines();
}