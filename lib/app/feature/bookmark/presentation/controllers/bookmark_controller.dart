import 'package:get/get.dart';
import '../../domain/use_cases/save_bookmark_use_case.dart';
import '../../domain/use_cases/get_bookmarks_use_case.dart';

class BookmarkController extends GetxController {
  final SaveBookmarkUseCase saveBookmarkUseCase;
  final GetBookmarksUseCase getBookmarksUseCase;

  BookmarkController({
    required this.saveBookmarkUseCase,
    required this.getBookmarksUseCase,
  });

  RxList<Map<String, dynamic>> bookmarks = <Map<String, dynamic>>[].obs;

  Future<void> toggleBookmark(String userId, Map<String, dynamic> article) async {
    if (bookmarks.any((bookmark) => bookmark['url'] == article['url'])) {
      // Remove from bookmarks
      bookmarks.removeWhere((bookmark) => bookmark['url'] == article['url']);
    } else {
      // Add to bookmarks
      bookmarks.add(article);
      await saveBookmarkUseCase.call(userId, article);
    }
  }

  Future<void> fetchBookmarks(String userId) async {
    final fetchedBookmarks = await getBookmarksUseCase.call(userId);
    bookmarks.assignAll(fetchedBookmarks);
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookmarks('current_user_id');
  }
}