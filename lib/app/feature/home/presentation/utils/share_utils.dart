import 'package:share_plus/share_plus.dart';
void shareArticle(String url, String title) {
  Share.share('$title\nRead more at: $url', subject: 'Check out this article!');
}

void shareOnFacebook(String url, String title) {
  Share.share('$title\nRead more at: $url', subject: 'Check out this article on Facebook!');
}

void shareOnTwitter(String url, String title) {
  Share.share('$title\nRead more at: $url', subject: 'Check out this article on Twitter!');
}

void shareOnWhatsApp(String url, String title) {
  Share.share('$title\nRead more at: $url', subject: 'Check out this article on WhatsApp!');
}
