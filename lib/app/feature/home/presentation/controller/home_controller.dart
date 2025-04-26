import 'package:get/get.dart';
import '../../domain/entities/article_entities.dart';
import '../../domain/usecases/get_top_headlines.dart';

class HomeController extends GetxController {
  final GetTopHeadlines getTopHeadlines;

  HomeController({required this.getTopHeadlines});

  RxList<ArticleEntity> articles = <ArticleEntity>[].obs;
  RxBool isLoading = true.obs;

  Future<void> fetchTopHeadlines() async {
    isLoading.value = true;
    final result = await getTopHeadlines.call();
    result.fold(
          (failure) => Get.snackbar('Error', failure),
          (newsEntity) {
        articles.assignAll(newsEntity.articles);
      },
    );
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }
}