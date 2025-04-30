import '../../domain/entities/article_entities.dart';
import '../models/article_model.dart';

extension ArticleModelMapper on ArticleModel {
  ArticleEntity toEntity() {
    return ArticleEntity(
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
      author: author,
      source: source != null
          ? SourceEntity(id: source!.id, name: source!.name)
          : null,
    );
  }
}