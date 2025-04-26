import 'package:hive/hive.dart';

class HiveCacheManager {
  static const String cacheBox = 'api_cache';

  // Save data to the cache
  static Future<void> saveCache(String key, Map<String, dynamic> data, {Duration? duration}) async {
    final box = await Hive.openBox(cacheBox); // Ensure the box is opened
    final expiryTime = duration != null ? DateTime.now().add(duration) : null;

    await box.put(
      key,
      {'data': data, 'expiry': expiryTime?.toIso8601String()},
    );
  }

  // Retrieve data from the cache
  static Future<Map<String, dynamic>?> getCache(String key) async {
    final box = await Hive.openBox(cacheBox); // Ensure the box is opened
    final cachedData = box.get(key);

    if (cachedData != null) {
      // Safely cast cachedData to Map<String, dynamic>
      final Map<String, dynamic> dataMap = Map<String, dynamic>.from(cachedData);

      final expiry = dataMap['expiry'] != null
          ? DateTime.parse(dataMap['expiry'])
          : null;

      if (expiry == null || DateTime.now().isBefore(expiry)) {
        return Map<String, dynamic>.from(dataMap['data']); // Safely cast 'data'
      } else {
        await box.delete(key); // Remove expired cache
      }
    }
    return null;
  }

  // Clear the cache
  static Future<void> clearCache() async {
    final box = await Hive.openBox(cacheBox); // Ensure the box is opened
    await box.clear();
  }
}