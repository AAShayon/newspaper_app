import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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


class ArticleDetailsScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  double textSizeFactor = 1.0; // Default text size factor
  Widget? fullArticleContent;
  bool isLoading = false;

  final ArticleScraper scraper = ArticleScraper();

  void updateTextSize(double factor) {
    setState(() {
      textSizeFactor = factor;
    });
  }


  Future<void> _fetchFullArticleContent() async {
    setState(() => isLoading = true);
    final content = await scraper.scrapeArticleContent(widget.article.url, titleToRemove: widget.article.title, fontSize: 20 * textSizeFactor);
    setState(() {
      fullArticleContent = content;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchFullArticleContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text("Article Details"),
        backgroundColor: AppColor.primaryColor(context),
        actions: [
          IconButton(
            icon: Icon(Icons.text_fields),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => TextSizeDialog(
                  textSizeFactor: textSizeFactor,
                  onTextSizeChanged: (factor) {
                    setState(() {
                      textSizeFactor = factor;
                    });
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Share Article'),
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
                  );
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArticleTitle(title: widget.article.title, textSizeFactor: textSizeFactor),
            SizedBox(height: 8.h),

            if (widget.article.urlToImage.isNotEmpty)
              ArticleImage(imageUrl: widget.article.urlToImage),
            SizedBox(height: 10.h),

            ArticleMetadata(
              author: widget.article.author ?? '',
              publishedAt: widget.article.formattedPublishedAt,
              sourceName: widget.article.source?.name,
              textSizeFactor: textSizeFactor,
            ),
            SizedBox(height: 16.h),

            ArticleContent(
              isLoading: isLoading,
              fullArticleContent: fullArticleContent,
              articleContent: widget.article.content,
              textSizeFactor: textSizeFactor,
            ),
          ],
        ),
      ),
    );
  }
}