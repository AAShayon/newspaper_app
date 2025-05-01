import 'package:get/get.dart';
import '../../domain/entities/article_entities.dart';
import '../../domain/entities/scraped_article_entity.dart';
import '../../domain/usecases/get_top_headlines.dart';
import '../../domain/usecases/scrape_article.dart';

class HomeController extends GetxController {
  final GetTopHeadlines getTopHeadlines;
  final GetCachedArticle getCachedArticle;

  HomeController({
    required this.getTopHeadlines,
    required this.getCachedArticle,
  });

  RxList<ArticleEntity> articles = <ArticleEntity>[].obs;
  RxBool isLoading = true.obs;
  RxDouble textSizeFactor = 1.0.obs; // For font size scaling
  Rx<ScrapedArticleEntity?> currentArticle = Rx<ScrapedArticleEntity?>(null);
  RxString articleError = ''.obs;
  RxString currentArticleTitle = ''.obs;

  // Fetch top headlines
  Future<void> fetchTopHeadlines() async {
    isLoading.value = true;
    articleError.value = '';
    final result = await getTopHeadlines.call();
    result.fold(
          (failure) => articleError.value = failure,
          (newsEntity) => articles.assignAll(newsEntity.articles),
    );
    isLoading.value = false;
  }

  // Load article content with caching
  Future<void> loadArticleContent(String url) async {
    isLoading.value = true;
    articleError.value = '';
    currentArticle.value = null;

    final result = await getCachedArticle.call(url);
    result.fold(
          (failure) => articleError.value = failure,
          (scrapedArticle) => currentArticle.value = scrapedArticle,
    );

    isLoading.value = false;
  }

  // Update text size preference
  void updateTextSize(double factor) {
    textSizeFactor.value = factor;
  }

  // Get current font size based on factor
  double getCurrentFontSize() {
    return 16.0 * textSizeFactor.value; // Base size 16, scaled by factor
  }

  @override
  void onInit() {
    super.onInit();
    fetchTopHeadlines();
  }
}