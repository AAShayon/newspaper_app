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

    // If cached data exists, use it directly
    if (cachedData != null && cachedData['data'] != null) {
      log("Using cached data.");
      try {
        return NewsModel.fromJson(cachedData['data']);
      } catch (e) {
        log("Error parsing cached data: $e");
      }
    }

    // If no cached data or error, fetch fresh from API if internet is available
    if (await isConnectedToInternet()) {
      log("Device is online. Fetching fresh data from API.");
      try {
        final response = await apiClient.get(
          ApiUrls.topHeadlines,
          queryParameters: {'sources': 'techcrunch', 'apiKey': ApiUrls.apiKey},
        );

        log("API Response: $response");

        if (response == null || response.isEmpty) {
          throw Exception('Empty or null API response');
        }

        final Map<String, dynamic> data = Map<String, dynamic>.from(response);
        final newsModel = NewsModel.fromJson(data);

        // Save data to cache
        log("Saving fresh data to cache: ${data.toString()}");
        await HiveCacheManager.saveCache(cacheKey, data, duration: Duration(hours: 1)); // you can manage expiry internally if needed

        return newsModel;
      } catch (e) {
        log("Error fetching data from API: $e");
        throw Exception('Error fetching top headlines: $e');
      }
    } else {
      log("Device is offline and no valid cached data available.");
      throw Exception('No internet connection and no valid cached data available.');
    }
  }

}