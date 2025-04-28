import 'package:intl/intl.dart';

import '../../data/models/article_model.dart';

class ArticleEntity {
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;
  final String? author;
  final SourceEntity? source; // Ensure this is SourceEntity?

  ArticleEntity({
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
    this.author,
    this.source,
  });

  // Convert ArticleEntity to ArticleModel
  ArticleModel toModel() {
    return ArticleModel(
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
      author: author,
      source: source?.toModel(), // Map SourceEntity back to SourceModel
    );
  }

  // Format the publishedAt field into a user-friendly format (yyyy-MM-dd hh:mm:ss)
  String get formattedPublishedAt {
    if (publishedAt.isEmpty) {
      return 'Unknown Date';
    }
    try {
      final dateTime = DateTime.parse(publishedAt.replaceAll('Z', ''));
      return DateFormat('yyyy-MM-dd hh:mm:ss').format(dateTime.toLocal());
    } catch (e) {
      return 'Invalid Date';
    }
  }
}

class SourceEntity {
  final String id;
  final String name;

  SourceEntity({required this.id, required this.name});

  // Convert SourceModel to SourceEntity
  factory SourceEntity.fromModel(SourceModel sourceModel) {
    return SourceEntity(
      id: sourceModel.id,
      name: sourceModel.name,
    );
  }

  // Convert SourceEntity to SourceModel
  SourceModel toModel() {
    return SourceModel(id: id, name: name);
  }
}