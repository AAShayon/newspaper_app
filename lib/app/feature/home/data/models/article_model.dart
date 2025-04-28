import 'package:intl/intl.dart';

class ArticleModel {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String content;
  final String publishedAt;
  final String? author;
  final SourceModel? source;

  ArticleModel({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.author,
    this.source,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    if (json == null) {
      throw Exception('Invalid JSON data for ArticleModel');
    }

    return ArticleModel(
      title: json['title'] as String? ?? 'No Title',
      description: json['description'] as String? ?? 'No Description',
      url: json['url'] as String? ?? '',
      urlToImage: json['urlToImage'] as String? ?? '',
      publishedAt: json['publishedAt'] as String? ?? '',
      content: json['content'] as String? ?? '',
      author: json['author'] as String?,
      source: json['source'] != null ? SourceModel.fromJson(json['source']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
      'author': author,
      'source': source?.toJson(),
    };
  }


  String get formattedPublishedAt {
    try {
      final dateTime = DateTime.parse(publishedAt.replaceAll('Z', ''));
      return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime.toLocal());
    } catch (e) {
      return 'Unknown Date';
    }
  }
}

class SourceModel {
  final String id;
  final String name;

  SourceModel({required this.id, required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      id: json['id'] as String? ?? 'No ID',
      name: json['name'] as String? ?? 'No Name',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}