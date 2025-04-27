import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../config/cache/hive_cache_manager.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/network/apiurls.dart';
import '../../../../core/utils/helper/helper_methods.dart';
import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel> getTopHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiClient apiClient;

  NewsRemoteDataSourceImpl(this.apiClient);


  @override
  Future<NewsModel> getTopHeadlines() async {
    const cacheKey = 'top_headlines_cache';
    final cachedData = await HiveCacheManager.getCache(cacheKey);

    if (await isConnectedToInternet()) {
      try {
        log("Fetching fresh data from API");
        final response = await apiClient.get(
          ApiUrls.topHeadlines,
          queryParameters: {'sources': 'techcrunch', 'apiKey': ApiUrls.apiKey},
        );

        final Map<String, dynamic> data = Map<String, dynamic>.from(response);
        final newsModel = NewsModel.fromJson(data);

        // Cache the fetched data for 1 hour
        await HiveCacheManager.saveCache(cacheKey, data, duration: Duration(hours: 1));

        return newsModel;
      } catch (e) {
        if (cachedData != null) {
          print("Using cached data due to network error");
          return NewsModel.fromJson(cachedData);
        }
        throw Exception('Error fetching top headlines: $e');
      }
    } else {
      if (cachedData != null) {
        print("Using cached data due to no internet connection");
        return NewsModel.fromJson(cachedData);
      }
      throw Exception('No internet connection and no cached data available');
    }
  }
}



// @override
// Future<NewsModel> getTopHeadlines() async {
//   const cacheKey = 'top_headlines_cache';
//   final cachedData = await HiveCacheManager.getCache(cacheKey);
//
//   if (cachedData != null) {
//     print("Returning cached data");
//     return NewsModel.fromJson(cachedData);
//   }
//
//   try {
//     print("Fetching fresh data from API");
//     final response = await apiClient.get(
//       ApiUrls.topHeadlines,
//       queryParameters: {'sources': 'techcrunch', 'apiKey': ApiUrls.apiKey},
//     );
//
//     final Map<String, dynamic> data = Map<String, dynamic>.from(response);
//     final newsModel = NewsModel.fromJson(data);
//
//     // Cache the fetched data for 1 hour
//     await HiveCacheManager.saveCache(cacheKey, data, duration: Duration(hours: 1));
//
//     return newsModel;
//   } catch (e) {
//     throw Exception('Error fetching top headlines: $e');
//   }
// }