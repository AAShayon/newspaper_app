abstract class BookmarkRepository {
  Future<void> saveBookmark(String userId, Map<String, dynamic> article);
  Future<List<Map<String, dynamic>>> getBookmarks(String userId);
  Future<void> removeBookmark(String userId, String bookmarkId);
}