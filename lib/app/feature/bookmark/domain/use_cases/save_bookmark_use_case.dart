import '../repositories/favorite_repository.dart';

class SaveBookmarkUseCase {
  final BookmarkRepository repository;

  SaveBookmarkUseCase(this.repository);

  Future<void> call(String userId, Map<String, dynamic> article) async {
    await repository.saveBookmark(userId, article);
  }
}