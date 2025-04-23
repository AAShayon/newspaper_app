import 'package:hive/hive.dart';

class HiveCacheManager {
  static const String cacheBox = 'api_cache';

  // Save data to the cache
  static Future<void> saveCache(String key, dynamic data, {Duration? duration}) async {
    final box = Hive.box(cacheBox);
    final expiryTime = duration != null ? DateTime.now().add(duration) : null;

    await box.put(key, {'data': data, 'expiry': expiryTime?.toIso8601String()});
  }

  // Retrieve data from the cache
  static Future<dynamic> getCache(String key) async {
    final box = Hive.box(cacheBox);
    final cachedData = box.get(key);

    if (cachedData != null) {
      final expiry = cachedData['expiry'] != null
          ? DateTime.parse(cachedData['expiry'])
          : null;

      if (expiry == null || DateTime.now().isBefore(expiry)) {
        return cachedData['data'];
      } else {
        await box.delete(key); // Remove expired cache
      }
    }
    return null;
  }

  // Clear the cache
  static Future<void> clearCache() async {
    final box = Hive.box(cacheBox);
    await box.clear();
  }
}
