import 'dart:developer';
import 'package:dartz/dartz.dart';
import '../../domain/entities/article_entities.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_datasource.dart';
import '../../domain/entities/news_entity.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, NewsEntity>> getTopHeadlines() async {
    try {
      // Fetch data from the remote data source
      final newsModel = await remoteDataSource.getTopHeadlines();

      // Map NewsModel to NewsEntity
      final newsEntity = NewsEntity(
        articles: newsModel.articles
            .map((articleModel) => ArticleEntity(
          title: articleModel.title,
          description: articleModel.description,
          url: articleModel.url,
          content: articleModel.content,
          author: articleModel.author,
          source: articleModel.source != null
              ? SourceEntity.fromModel(articleModel.source!)
              : null,
          urlToImage: articleModel.urlToImage,
          publishedAt: articleModel.publishedAt,
        ))
            .toList(),
      );

      return Right(newsEntity); // Return success with NewsEntity
    } catch (e) {
      log(e.toString());
      return Left('Failed to fetch top headlines'); // Return failure with an error message
    }
  }
}