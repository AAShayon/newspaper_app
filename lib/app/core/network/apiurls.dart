import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiUrls {
  static const String baseUrl = 'https://newsapi.org/v2';
  static String topHeadlines = '$baseUrl/top-headlines';
  static String apiKey = dotenv.env['NEWS_API_KEY'] ?? '';
}