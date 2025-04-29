import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/injection/di.dart';
import 'package:newspaper_app/app/feature/bookmark/domain/use_cases/remove_bookmark_use_case.dart';
import '../../../../core/utils/bookmark_utils.dart';
import '../../domain/use_cases/save_bookmark_use_case.dart';
import '../../domain/use_cases/get_bookmarks_use_case.dart';

class BookmarkController extends GetxController {
  final SaveBookmarkUseCase saveBookmarkUseCase;
  final GetBookmarksUseCase getBookmarksUseCase;
  final RemoveBookmarkUseCase removeBookmarkUseCase;

  BookmarkController({
    required this.saveBookmarkUseCase,
    required this.getBookmarksUseCase,
    required this.removeBookmarkUseCase,
  });

  RxList<Map<String, dynamic>> bookmarks = <Map<String, dynamic>>[].obs;

  Future<void> toggleBookmark(Map<String, dynamic> article) async {
    try {
      final currentUser = locator.get<FirebaseAuth>().currentUser;
      if (currentUser == null) {
        Get.snackbar('Error', 'You must be logged in to bookmark articles');
        return;
      }

      final userId = currentUser.uid;
      final bookmarkId = generateBookmarkId(article['url']);
      final isAlreadyBookmarked = isBookmarked(article['url']);

      if (isAlreadyBookmarked) {
        bookmarks.removeWhere((bookmark) => bookmark['url'] == article['url']);
        await removeBookmarkUseCase.call(userId, bookmarkId);
      } else {
        bookmarks.add(article);
        await saveBookmarkUseCase.call(userId, article);
      }
      update();
    } catch (e) {
      Get.snackbar('Error', 'Failed to update bookmark: ${e.toString()}');
      // Revert UI change if operation failed
      if (isBookmarked(article['url'])) {
        bookmarks.removeWhere((bookmark) => bookmark['url'] == article['url']);
      } else {
        bookmarks.add(article);
      }
      update();
    }
  }

  Future<void> fetchBookmarks() async {
    try {
      final currentUser = locator.get<FirebaseAuth>().currentUser;
      if (currentUser != null) {
        final fetchedBookmarks = await getBookmarksUseCase.call(currentUser.uid);
        bookmarks.assignAll(fetchedBookmarks);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch bookmarks: ${e.toString()}');
    }
  }

  bool isBookmarked(String url) {
    final bookmarkId = generateBookmarkId(url);
    return bookmarks.any((bookmark) => generateBookmarkId(bookmark['url']) == bookmarkId);
  }

  @override
  void onInit() {
    super.onInit();
    fetchBookmarks();
  }
}