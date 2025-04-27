import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/utils/bookmark_utils.dart';

abstract class BookmarkRemoteDataSource {
  Future<void> saveBookmark(String userId, Map<String, dynamic> article);
  Future<List<Map<String, dynamic>>> getBookmarks(String userId);
}

class BookmarkRemoteDataSourceImpl implements BookmarkRemoteDataSource {
  final FirebaseFirestore firestore;

  BookmarkRemoteDataSourceImpl(this.firestore);

  @override
  Future<void> saveBookmark(String userId, Map<String, dynamic> article) async {
    final bookmarkId = generateBookmarkId(article['url']);
    await firestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .doc(bookmarkId)
        .set(article, SetOptions(merge: true));
  }

  @override
  Future<List<Map<String, dynamic>>> getBookmarks(String userId) async {
    final snapshot = await firestore
        .collection('users')
        .doc(userId)
        .collection('bookmarks')
        .get();
    return snapshot.docs.map((doc) => doc.data()).toList();
  }
}