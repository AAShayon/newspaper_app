import '../../domain/repositories/favorite_repository.dart';
import '../datasources/bookmark_local_datasource.dart';
import '../datasources/bookmark_remote_datasource.dart';


class BookmarkRepositoryImpl implements BookmarkRepository {
  final BookmarkRemoteDataSource remoteDataSource;
  final BookmarkLocalDataSource localDataSource;

  BookmarkRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<void> saveBookmark(String userId, Map<String, dynamic> article) async {
    await remoteDataSource.saveBookmark(userId, article);
    await localDataSource.saveBookmark(userId, article);
  }

  @override
  Future<List<Map<String, dynamic>>> getBookmarks(String userId) async {
    try {
      final remoteBookmarks = await remoteDataSource.getBookmarks(userId);
      return remoteBookmarks;
    } catch (_) {
      return await localDataSource.getBookmarks(userId);
    }
  }
  @override
  Future<void> removeBookmark(String userId, String bookmarkId) async {
    // Remove from both remote and local data sources
    await remoteDataSource.removeBookmark(userId, bookmarkId);
    await localDataSource.removeBookmark(userId, bookmarkId);
  }
}