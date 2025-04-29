import '../../../home/data/models/article_model.dart';
import '../../../home/domain/entities/article_entities.dart';

class ArticleFactory {
  static ArticleEntity convertFromMap(Map<String, dynamic> articleMap) {
    final articleModel = ArticleModel.fromJson(articleMap);
    return ArticleEntity(
      title: articleModel.title,
      description: articleModel.description,
      url: articleModel.url,
      urlToImage: articleModel.urlToImage,
      publishedAt: articleModel.publishedAt,
      content: articleModel.content,
      author: articleModel.author,
      source: articleModel.source != null ? SourceEntity.fromModel(articleModel.source!) : null,
    );
  }
}
