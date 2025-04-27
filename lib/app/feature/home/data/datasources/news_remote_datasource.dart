import 'dart:developer';
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

    log("Cached data: ${cachedData?.toString() ?? 'No cached data'}");

    // Check if valid cached data exists
    if (cachedData != null && cachedData['expiry'] != null) {
      try {
        final expiryTime = DateTime.parse(cachedData['expiry']);
        if (DateTime.now().isBefore(expiryTime)) {
          log("Using valid cached data.");
          return NewsModel.fromJson(cachedData['data']);
        } else {
          log("Cached data has expired.");
        }
      } catch (e) {
        log("Error parsing expiry time: $e");
      }
    } else {
      log("No expiry time found in cache.");
    }


    // Fetch fresh data only if no valid cached data exists and the device is online
    if (await isConnectedToInternet()) {
      log("Device is online. Fetching fresh data from API.");
      try {
        final response = await apiClient.get(
          ApiUrls.topHeadlines,
          queryParameters: {'sources': 'techcrunch', 'apiKey': ApiUrls.apiKey},
        );

        final Map<String, dynamic> data = Map<String, dynamic>.from(response);
        final newsModel = NewsModel.fromJson(data);

        // Save data to cache for 1 hour
        log("Saving fresh data to cache: ${data.toString()}");
        await HiveCacheManager.saveCache(cacheKey, data, duration: Duration(hours: 1));

        return newsModel;
      } catch (e) {
        log("Error fetching data from API: $e");
        if (cachedData != null) {
          log("Using cached data due to network error.");
          return NewsModel.fromJson(cachedData['data']);
        }
        throw Exception('Error fetching top headlines: $e');
      }
    } else {
      log("Device is offline.");
      if (cachedData != null) {
        log("Using cached data due to no internet connection.");
        return NewsModel.fromJson(cachedData['data']);
      }
      throw Exception('No internet connection and no valid cached data available.');
    }
  }
}