import '../../../../core/network/api_client.dart';
import '../../../../core/network/apiurls.dart';

import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel> getTopHeadlines();
}

class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final ApiClient apiClient;

  NewsRemoteDataSourceImpl(this.apiClient);

  @override
  Future<NewsModel> getTopHeadlines() async{
    final response = await apiClient.get(
      ApiUrls.topHeadlines,
      queryParameters: {'sources': 'techcrunch', 'apiKey': ApiUrls.apiKey},
    );
    if( response.isNotEmpty){
      return NewsModel.fromJson(response);
    }
    else{
      throw Exception('Failed to fetch top headlines');
    }

  }

  // @override
  // Future<NewsModel> getTopHeadlines() async {
  //   const cacheKey = 'top_headlines_cache';
  //   final cachedData = await HiveCacheManager.getCache(cacheKey);
  //
  //   log("Cached data: ${cachedData?.toString() ?? 'No cached data'}");
  //
  //   if (await isConnectedToInternet()) {
  //     log("Device is online. Fetching fresh data from API.");
  //     try {
  //       final response = await apiClient.get(
  //         ApiUrls.topHeadlines,
  //         queryParameters: {'sources': 'techcrunch', 'apiKey': ApiUrls.apiKey},
  //       );

  //       log("API Response: $response");
  //
  //       if (response == null || response.isEmpty) {
  //         throw Exception('Empty or null API response');
  //       }
  //
  //       final Map<String, dynamic> data = Map<String, dynamic>.from(response);
  //       final newsModel = NewsModel.fromJson(data);
  //       return newsModel;
  //     } catch (e) {
  //       log("Error fetching data from API: $e");
  //       throw Exception('Error fetching top headlines: $e');
  //     }
  //   } else {
  //     log("Device is offline and no valid cached data available.");
  //     throw Exception('No internet connection and no valid cached data available.');
  //   }
  // }

}