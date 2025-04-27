import 'dart:core';

String generateBookmarkId(String url) {
  final uri = Uri.parse(url);
  final normalizedUrl = '${uri.scheme}://${uri.host}${uri.path}';
  return normalizedUrl.hashCode.toString();
}