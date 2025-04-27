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
  Future<NewsModel> getTopHeadlines() async {
    try {
      final response = await apiClient.get(
        ApiUrls.topHeadlines,
        queryParameters: {'sources': 'techcrunch', 'apiKey': ApiUrls.apiKey},
      );
      final Map<String, dynamic> data = Map<String, dynamic>.from(response);
      return NewsModel.fromJson(data);
    } catch (e) {
      throw Exception('Error fetching top headlines: $e');
    }
  }
}