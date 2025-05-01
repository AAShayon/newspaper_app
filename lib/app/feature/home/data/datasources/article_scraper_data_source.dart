// import 'package:newspaper_app/app/core/network/api_client.dart';
//
// abstract class ArticleScraperDataSource {
//   Future<String> scrapeArticleHtml(String articleUrl);
// }
//
// class ArticleScraperDataSourceImpl implements ArticleScraperDataSource {
//   final ApiClient apiClient;
//
//   ArticleScraperDataSourceImpl(this.apiClient);
//
//   @override
//   Future<String> scrapeArticleHtml(String articleUrl) async {
//     final response = await apiClient.getRawResponse(articleUrl);
//     if (response?.statusCode == 200 && response!.data is String) {
//       return response.data as String;
//     }
//     throw Exception('Failed to scrape article content');
//   }
// }