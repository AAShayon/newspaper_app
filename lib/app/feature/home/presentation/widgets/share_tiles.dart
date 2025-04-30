import 'package:flutter/material.dart';
class ShareToTile extends StatelessWidget {
  final String platform;
  final IconData icon;
  final Function(String url, String title) shareFunction;
  final String articleUrl;
  final String articleTitle;

  const ShareToTile({
    super.key,
    required this.platform,
    required this.icon,
    required this.shareFunction,
    required this.articleUrl,
    required this.articleTitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(platform),
      onTap: () {
        Navigator.pop(context);
        shareFunction(articleUrl, articleTitle);
      },
    );
  }
}