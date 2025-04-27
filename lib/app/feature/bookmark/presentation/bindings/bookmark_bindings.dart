import 'package:get/get.dart';
import 'package:newspaper_app/app/config/injection/di.dart';
import 'package:newspaper_app/app/feature/bookmark/domain/use_cases/save_bookmark_use_case.dart';
import 'package:newspaper_app/app/feature/bookmark/presentation/controllers/bookmark_controller.dart';

import '../../domain/use_cases/get_bookmarks_use_case.dart';


class BookmarkBinding implements Bindings {
  @override
  void dependencies() {
  Get.lazyPut<BookmarkController>(()=>BookmarkController(
    saveBookmarkUseCase: locator.get<SaveBookmarkUseCase>(),
    getBookmarksUseCase: locator.get<GetBookmarksUseCase>(),
  ));
  }
}