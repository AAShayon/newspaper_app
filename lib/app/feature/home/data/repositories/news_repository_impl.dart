import 'package:dartz/dartz.dart';
import 'package:newspaper_app/app/feature/home/data/mapper/article_model_mapper.dart';
import '../../../../core/utils/helper/helper_methods.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/entities/scraped_article_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_local_datasources.dart';
import '../datasources/news_remote_datasource.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;
  final NewsLocalDataSource localDataSource;
  // final ArticleScraperDataSource scraperDataSource;

  NewsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    // required this.scraperDataSource,
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
  @override
  Future<Either<String, ScrapedArticleEntity>> getArticleContent(String url) async {
    final isConnected = await isConnectedToInternet();
    if (isConnected) {
      try {
        final htmlContent = await remoteDataSource.scrapeArticleHtml(url);
        final scrapedArticle = ScrapedArticleEntity(
          articleUrl: url,
          htmlContent: htmlContent,
          scrapedAt: DateTime.now(),
        );

        await localDataSource.cacheScrapedArticle(scrapedArticle);
        return Right(scrapedArticle);
      } catch (e) {
        return Left('Failed to fetch article content: $e');
      }
    } else {
      try {
        final cachedArticle = await localDataSource.getCachedScrapedArticle(url);
        if (cachedArticle != null) {
          return Right(cachedArticle);
        } else {
          return const Left('Failed to Load Full Content');
        }
      } catch (e) {
        return Left('Failed to Load Full Content');
      }
    }
  }
}