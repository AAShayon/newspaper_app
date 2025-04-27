import 'package:hive/hive.dart';

import '../../../../core/utils/bookmark_utils.dart';

abstract class BookmarkLocalDataSource {
  Future<void> saveBookmark(String userId, Map<String, dynamic> article);
  Future<List<Map<String, dynamic>>> getBookmarks(String userId);
}

class BookmarkLocalDataSourceImpl implements BookmarkLocalDataSource {
  static const String bookmarkBox = 'bookmarks';

  @override
  Future<void> saveBookmark(String userId, Map<String, dynamic> article) async {
    final bookmarkId = generateBookmarkId(article['url']);
    final box = await Hive.openBox(bookmarkBox);
    final bookmarks = box.get(userId, defaultValue: <Map<String, dynamic>>[]);
    bookmarks.add({...article, 'id': bookmarkId});
    await box.put(userId, bookmarks);
  }

  @override
  Future<List<Map<String, dynamic>>> getBookmarks(String userId) async {
    final box = await Hive.openBox(bookmarkBox);
    return box.get(userId, defaultValue: <Map<String, dynamic>>[]);
  }
}