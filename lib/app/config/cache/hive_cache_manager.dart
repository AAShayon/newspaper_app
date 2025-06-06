
import 'dart:developer';

import 'package:hive/hive.dart';

class HiveCacheManager {
  static const String cacheBox = 'api_cache';

  // Retrieve data from the cache
  static Future<Map<String, dynamic>?> getCache(String key) async {
    final box = await Hive.openBox(cacheBox);
    final cachedData = box.get(key);

    if (cachedData != null) {
      try {
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
      } catch (e) {
        log("Error parsing cached data: $e");
        await box.delete(key); // Clear corrupted cache
      }
    }
    return null;
  }

  // Save data to the cache
  static Future<void> saveCache(String key, Map<String, dynamic> data, {Duration? duration}) async {
    final box = await Hive.openBox(cacheBox);
    final expiryTime = duration != null ? DateTime.now().add(duration) : null;
    await box.put(
      key,
      {'data': data, 'expiry': expiryTime?.toIso8601String()},
    );
  }

  // Clear the cache
  static Future<void> clearCache() async {
    final box = await Hive.openBox(cacheBox);
    await box.clear();
  }
}