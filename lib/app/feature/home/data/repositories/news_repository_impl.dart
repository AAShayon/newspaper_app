import 'package:dartz/dartz.dart';
import 'package:newspaper_app/app/feature/home/data/mapper/article_model_mapper.dart';

import '../../../../core/utils/helper/helper_methods.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_datasources.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<String, NewsEntity>> getTopHeadlines() async {
    final isConnected = await isConnectedToInternet();
    if (isConnected) {
      try {
        final newsModel = await remoteDataSource.getTopHeadlines();
        await localDataSource.cacheNews(newsModel);
        final articles = newsModel.articles.map((e) => e.toEntity()).toList();
        return Right(NewsEntity(articles: articles));
      } catch (e) {
        return const Left('Failed to fetch news from the server.');
      }
    } else {
      try {
        final cachedNews = await localDataSource.getCachedNews();
        final articles = cachedNews.articles.map((e) => e.toEntity()).toList();
        return Right(NewsEntity(articles: articles));
      } catch (_) {
        return const Left('No internet and no cached data available.');
      }
    }
  }
}