import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newspaper_app/app/config/theme/color.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/article_entities.dart';
import '../utils/article_scraper.dart';

class ArticleDetailsScreen extends StatefulWidget {
  final ArticleEntity article;

  const ArticleDetailsScreen({Key? key, required this.article}) : super(key: key);

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  double textSizeFactor = 1.0; // Default text size factor
  String? fullArticleContent;
  bool isLoading = false;

  final ArticleScraper scraper = ArticleScraper();

  void updateTextSize(double factor) {
    setState(() {
      textSizeFactor = factor;
    });
  }

  void shareToSocialMedia(String url, String title) {
    Share.share(
      '$title\nRead more at: $url',
      subject: 'Check out this article!',
    );
  }

  void shareToFacebook(String url, String title) {
    Share.share(
      '$title\nRead more at: $url',
      subject: 'Check out this article on Facebook!',
    );
  }

  void shareToTwitter(String url, String title) {
    Share.share(
      '$title\nRead more at: $url',
      subject: 'Check out this article on Twitter!',
    );
  }

  void shareToWhatsApp(String url, String title) {
    Share.share(
      '$title\nRead more at: $url',
      subject: 'Check out this article on WhatsApp!',
    );
  }

  Future<void> _fetchFullArticleContent() async {
    setState(() => isLoading = true);
    try {
      final content = await scraper.scrapeArticleContent(widget.article.url);
      setState(() {
        fullArticleContent = content;
        isLoading = false;
      });
    } catch (e) {
      print("Error scraping article: $e");
      setState(() {
        fullArticleContent = null;
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchFullArticleContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Article Details"),
        backgroundColor: AppColor.primaryColor(context),
        actions: [
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
                        ListTile(
                          leading: Icon(Icons.facebook),
                          title: Text('Facebook'),
                          onTap: () {
                            Navigator.pop(context);
                            shareToFacebook(widget.article.url, widget.article.title);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.share),
                          title: Text('Twitter'),
                          onTap: () {
                            Navigator.pop(context);
                            shareToTwitter(widget.article.url, widget.article.title);
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.share),
                          title: Text('WhatsApp'),
                          onTap: () {
                            Navigator.pop(context);
                            shareToWhatsApp(widget.article.url, widget.article.title);
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.text_fields),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Select Text Size'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RadioListTile<double>(
                          title: Text('Small'),
                          value: 0.8,
                          groupValue: textSizeFactor,
                          onChanged: (value) {
                            if (value != null) {
                              updateTextSize(value);
                              Navigator.pop(context); // Close dialog
                            }
                          },
                        ),
                        RadioListTile<double>(
                          title: Text('Medium'),
                          value: 1.0,
                          groupValue: textSizeFactor,
                          onChanged: (value) {
                            if (value != null) {
                              updateTextSize(value);
                              Navigator.pop(context); // Close dialog
                            }
                          },
                        ),
                        RadioListTile<double>(
                          title: Text('Big'),
                          value: 1.5,
                          groupValue: textSizeFactor,
                          onChanged: (value) {
                            if (value != null) {
                              updateTextSize(value);
                              Navigator.pop(context); // Close dialog
                            }
                          },
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
            Text(
              widget.article.title,
              style: TextStyle(
                fontSize: 24.sp * textSizeFactor,
                fontWeight: FontWeight.bold,
                color: AppColor.textColor(context),
              ),
            ),
            SizedBox(height: 8.h),

            // Display image if available
            if (widget.article.urlToImage.isNotEmpty)
              CachedNetworkImage(
                imageUrl: widget.article.urlToImage ?? 'https://via.placeholder.com/150',
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: double.infinity,
                height: 250.h,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 10.h),

            Text(
              "Author: ${widget.article.author}",
              style: TextStyle(
                fontSize: 14.sp * textSizeFactor,
                color: AppColor.secondaryTextColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),

            Text(
              "Published At: ${widget.article.formattedPublishedAt}",
              style: TextStyle(
                fontSize: 14.sp * textSizeFactor,
                color: AppColor.secondaryTextColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.h),

            Text(
              "Source name: ${widget.article.source?.name}",
              style: TextStyle(
                fontSize: 14.sp * textSizeFactor,
                color: AppColor.secondaryTextColor(context),
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16.h),

            // Full article content from web scraping
            if (isLoading)
              Center(child: CircularProgressIndicator())
            else if (fullArticleContent != null)
              Text(
                fullArticleContent!,
                style: TextStyle(
                  fontSize: 16.sp * textSizeFactor,
                  color: AppColor.secondaryTextColor(context),
                ),
              )
            else
              Text(
                "Could not load full article content.",
                style: TextStyle(
                  fontSize: 16.sp * textSizeFactor,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}