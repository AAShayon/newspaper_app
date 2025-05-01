import 'package:get/get.dart';

import 'package:newspaper_app/app/feature/home/domain/usecases/scrape_article.dart';
import '../../../../config/injection/di.dart';
import '../../../auth/presentation/bindings/auth_binding.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
    Get.lazyPut<HomeController>(() => HomeController(
        getTopHeadlines: locator.get<GetTopHeadlines>(),
        getCachedArticle: locator.get<GetCachedArticle>()));

  }
}
