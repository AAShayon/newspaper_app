import '../../../../core/network/api_client.dart';
import '../../../../core/network/apiurls.dart';

import '../models/news_model.dart';

abstract class NewsRemoteDataSource {
  Future<NewsModel> getTopHeadlines();
  Future<String> scrapeArticleHtml(String articleUrl);
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
  @override
  Future<String> scrapeArticleHtml(String articleUrl) async {
    final response = await apiClient.getRawResponse(articleUrl);
    if (response?.statusCode == 200 && response!.data is String) {
      return response.data as String;
    }
    throw Exception('Failed to scrape article content');
  }
}