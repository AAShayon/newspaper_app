import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

void shareArticle(BuildContext context, String url, String title) async {
  final box = context.findRenderObject() as RenderBox?;

  final shareResult = await SharePlus.instance.share(
    ShareParams(
      text: '$title\nRead more at: $url',
      subject: 'Check out this article!',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & (box.size ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text("Share result: ${shareResult.status.name}")),
  );
}
