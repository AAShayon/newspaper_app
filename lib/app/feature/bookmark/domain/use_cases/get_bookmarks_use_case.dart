import '../repositories/favorite_repository.dart';

class GetBookmarksUseCase {
  final BookmarkRepository repository;

  GetBookmarksUseCase(this.repository);

  Future<List<Map<String, dynamic>>> call(String userId) async {
    return await repository.getBookmarks(userId);
  }
}