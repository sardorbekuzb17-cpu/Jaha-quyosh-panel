import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static const String _panelsKey = 'cached_panels';
  static const String _pricingKey = 'cached_pricing';
  static const String _contactKey = 'cached_contact';
  static const String _lastUpdateKey = 'last_update_';

  // Ma'lumotlarni cache ga saqlash
  static Future<void> cachePanels(List<dynamic> panels) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_panelsKey, jsonEncode(panels));
    await prefs.setInt(
        _lastUpdateKey + 'panels', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> cachePricing(List<dynamic> pricing) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_pricingKey, jsonEncode(pricing));
    await prefs.setInt(
        _lastUpdateKey + 'pricing', DateTime.now().millisecondsSinceEpoch);
  }

  static Future<void> cacheContact(Map<String, dynamic> contact) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_contactKey, jsonEncode(contact));
    await prefs.setInt(
        _lastUpdateKey + 'contact', DateTime.now().millisecondsSinceEpoch);
  }

  // Cache dan ma'lumotlarni olish
  static Future<List<dynamic>?> getCachedPanels() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_panelsKey);
    if (cachedData != null) {
      return jsonDecode(cachedData);
    }
    return null;
  }

  static Future<List<dynamic>?> getCachedPricing() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_pricingKey);
    if (cachedData != null) {
      return jsonDecode(cachedData);
    }
    return null;
  }

  static Future<Map<String, dynamic>?> getCachedContact() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(_contactKey);
    if (cachedData != null) {
      return jsonDecode(cachedData);
    }
    return null;
  }

  // Cache yangilanish vaqtini tekshirish
  static Future<bool> isCacheExpired(String type,
      {int maxAgeHours = 24}) async {
    final prefs = await SharedPreferences.getInstance();
    final lastUpdate = prefs.getInt(_lastUpdateKey + type) ?? 0;
    final now = DateTime.now().millisecondsSinceEpoch;
    final maxAge = maxAgeHours * 60 * 60 * 1000; // milliseconds

    return (now - lastUpdate) > maxAge;
  }

  // Cache ni tozalash
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_panelsKey);
    await prefs.remove(_pricingKey);
    await prefs.remove(_contactKey);
  }

  // Statistika saqlash
  static Future<void> saveUsageStats(String action) async {
    final prefs = await SharedPreferences.getInstance();
    final stats = prefs.getStringList('usage_stats') ?? [];
    final timestamp = DateTime.now().toIso8601String();
    stats.add('$timestamp:$action');

    // Faqat oxirgi 100 ta harakatni saqlash
    if (stats.length > 100) {
      stats.removeRange(0, stats.length - 100);
    }

    await prefs.setStringList('usage_stats', stats);
  }

  static Future<List<String>> getUsageStats() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('usage_stats') ?? [];
  }
}
