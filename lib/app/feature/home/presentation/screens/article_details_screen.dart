// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:newspaper_app/app/config/theme/color.dart';
// import 'package:newspaper_app/app/feature/home/presentation/utils/share_utils.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import '../../domain/entities/article_entities.dart';
// import '../utils/article_scraper.dart';
// import '../widgets/article_content.dart';
// import '../widgets/article_image.dart';
// import '../widgets/article_metadata.dart';
// import '../widgets/article_title.dart';
// import '../widgets/share_tiles.dart';
// import '../widgets/text_size_dialog.dart';
//
//
// class ArticleDetailsScreen extends StatefulWidget {
//   final ArticleEntity article;
//
//   const ArticleDetailsScreen({super.key, required this.article});
//
//   @override
//   State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
// }
//
// class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
//   double textSizeFactor = 1.0; // Default text size factor
//   Widget? fullArticleContent;
//   bool isLoading = false;
//
//   final ArticleScraper scraper = ArticleScraper();
//
//   void updateTextSize(double factor) {
//     setState(() {
//       textSizeFactor = factor;
//     });
//   }
//
//
//   Future<void> _fetchFullArticleContent() async {
//     setState(() => isLoading = true);
//     final content = await scraper.scrapeArticleContent(widget.article.url, titleToRemove: widget.article.title, fontSize: 20 * textSizeFactor);
//     setState(() {
//       fullArticleContent = content;
//       isLoading = false;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchFullArticleContent();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.white,
//       appBar: AppBar(
//         title: Text("Article Details"),
//         backgroundColor: AppColor.primaryColor(context),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.text_fields),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => TextSizeDialog(
//                   textSizeFactor: textSizeFactor,
//                   onTextSizeChanged: (factor) {
//                     setState(() {
//                       textSizeFactor = factor;
//                     });
//                   },
//                 ),
//               );
//             },
//           ),
//           IconButton(
//             icon: Icon(Icons.share),
//             onPressed: () {
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) {
//                   return AlertDialog(
//                     title: Text('Share Article'),
//                     content: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         ShareToTile(
//                           platform: 'Facebook',
//                           icon: Icons.facebook,
//                           shareFunction: shareOnFacebook,
//                           articleUrl: widget.article.url,
//                           articleTitle: widget.article.title,
//                         ),
//                         ShareToTile(
//                           platform: 'Twitter',
//                           icon: FontAwesomeIcons.twitter,
//                           shareFunction: shareOnTwitter,
//                           articleUrl: widget.article.url,
//                           articleTitle: widget.article.title,
//                         ),
//                         ShareToTile(
//                           platform: 'WhatsApp',
//                           icon: FontAwesomeIcons.whatsapp,
//                           shareFunction: shareOnWhatsApp,
//                           articleUrl: widget.article.url,
//                           articleTitle: widget.article.title,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             ArticleTitle(title: widget.article.title, textSizeFactor: textSizeFactor),
//             SizedBox(height: 8.h),
//
//             if (widget.article.urlToImage.isNotEmpty)
//               ArticleImage(imageUrl: widget.article.urlToImage),
//             SizedBox(height: 10.h),
//
//             ArticleMetadata(
//               author: widget.article.author ?? '',
//               publishedAt: widget.article.formattedPublishedAt,
//               sourceName: widget.article.source?.name,
//               textSizeFactor: textSizeFactor,
//             ),
//             SizedBox(height: 16.h),
//
//             ArticleContent(
//               isLoading: isLoading,
//               fullArticleContent: fullArticleContent,
//               articleContent: widget.article.content,
//               textSizeFactor: textSizeFactor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// article_details_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:newspaper_app/app/feature/home/presentation/utils/share_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../domain/entities/article_entities.dart';
import '../utils/article_scraper.dart';
import '../widgets/article_content.dart';
import '../widgets/article_image.dart';
import '../widgets/article_metadata.dart';
import '../widgets/article_title.dart';
import '../widgets/share_tiles.dart';
import '../widgets/text_size_dialog.dart';
import '../controller/home_controller.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  final controller = Get.find<HomeController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      controller.loadArticleContent(widget.article.url);
    });
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: _buildAppBar(context, controller),
      body: _buildArticleBody(controller),
    );
  }

  AppBar _buildAppBar(BuildContext context, HomeController controller) {
    return AppBar(
      title: const Text("Article Details"),
      backgroundColor: AppColor.primaryColor(context),
      actions: [
        IconButton(
          icon: const Icon(Icons.text_fields),
          onPressed: () => _showTextSizeDialog(controller),
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () => _showShareDialog(),
        ),
      ],
    );
  }

  Widget _buildArticleBody(HomeController controller) {
    return Obx(() {
      return SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Always show these article details
            ArticleTitle(
              title: widget.article.title,
              textSizeFactor: controller.textSizeFactor.value,
            ),
            SizedBox(height: 8.h),

            if (widget.article.urlToImage.isNotEmpty)
              ArticleImage(imageUrl: widget.article.urlToImage),
            SizedBox(height: 10.h),

            ArticleMetadata(
              author: widget.article.author ?? '',
              publishedAt: widget.article.formattedPublishedAt,
              sourceName: widget.article.source?.name,
              textSizeFactor: controller.textSizeFactor.value,
            ),
            SizedBox(height: 16.h),

            // Handle the article content section separately
            _buildArticleContentSection(controller),
          ],
        ),
      );
    });
  }

  Widget _buildArticleContentSection(HomeController controller) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.articleError.isNotEmpty) {
        return Column(
          children: [
            Text(
              controller.articleError.value,
              style: TextStyle(
                fontSize: 16.sp * controller.textSizeFactor.value,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 16.h),
            // Show basic content as fallback
            Text(
              widget.article.content
                  .replaceAll(RegExp(r'\[\+\d+ chars\]'), '')
                  .trim(),
              style: TextStyle(
                fontSize: 16.sp * controller.textSizeFactor.value,
                color: AppColor.textColor(Get.context!),
              ),
            ),
          ],
        );
      }

      if (controller.currentArticle.value != null) {
        return ArticleContent(
          fullArticleContent: ArticleScraperHelper.buildArticleWidget(
            controller.currentArticle.value!,
            titleToRemove: widget.article.title,
            fontSize: controller.getCurrentFontSize(),
          ),
          articleContent: widget.article.content,
          textSizeFactor: controller.textSizeFactor.value,
          isLoading: controller.isLoading.value,
        );
      }

      // Default fallback - show basic content
      return Text(
        widget.article.content
            .replaceAll(RegExp(r'\[\+\d+ chars\]'), '')
            .trim(),
        style: TextStyle(
          fontSize: 16.sp * controller.textSizeFactor.value,
          color: AppColor.textColor(Get.context!),
        ),
      );
    });
  }

  void _showTextSizeDialog(HomeController controller) {
    showDialog(
      context: Get.context!,
      builder: (context) => TextSizeDialog(
        textSizeFactor: controller.textSizeFactor.value,
        onTextSizeChanged: controller.updateTextSize,
      ),
    );
  }

  void _showShareDialog() {
    showDialog(
      context: Get.context!,
      builder: (context) => AlertDialog(
        title: const Text('Share Article'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ShareToTile(
              platform: 'Facebook',
              icon: Icons.facebook,
              shareFunction: shareOnFacebook,
              articleUrl: widget.article.url,
              articleTitle: widget.article.title,
            ),
            ShareToTile(
              platform: 'Twitter',
              icon: FontAwesomeIcons.twitter,
              shareFunction: shareOnTwitter,
              articleUrl: widget.article.url,
              articleTitle: widget.article.title,
            ),
            ShareToTile(
              platform: 'WhatsApp',
              icon: FontAwesomeIcons.whatsapp,
              shareFunction: shareOnWhatsApp,
              articleUrl: widget.article.url,
              articleTitle: widget.article.title,
            ),
          ],
        ),
      ),
    );
  }
}