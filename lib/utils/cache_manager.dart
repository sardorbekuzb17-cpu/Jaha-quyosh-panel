import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CacheManager {
  static final CacheManager _instance = CacheManager._internal();
  factory CacheManager() => _instance;
  CacheManager._internal();

  final Map<String, dynamic> _memoryCache = {};
  static const int _defaultCacheTime = 3600; // 1 soat

  Future<void> setData(String key, dynamic value, {int? expirySeconds}) async {
    final prefs = await SharedPreferences.getInstance();
    final expiryTime = DateTime.now()
        .add(Duration(seconds: expirySeconds ?? _defaultCacheTime))
        .millisecondsSinceEpoch;

    final cacheData = {
      'value': value,
      'expiry': expiryTime,
    };

    // Memory cache
    _memoryCache[key] = cacheData;

    // Persistent cache
    await prefs.setString(key, jsonEncode(cacheData));
  }

  Future<T?> getData<T>(String key) async {
    // Birinchi memory cache dan tekshirish
    if (_memoryCache.containsKey(key)) {
      final data = _memoryCache[key];
      if (DateTime.now().millisecondsSinceEpoch < data['expiry']) {
        return data['value'] as T;
      }
      _memoryCache.remove(key);
    }

    // Disk cache dan tekshirish
    final prefs = await SharedPreferences.getInstance();
    final cachedData = prefs.getString(key);
    
    if (cachedData != null) {
      final data = jsonDecode(cachedData);
      if (DateTime.now().millisecondsSinceEpoch < data['expiry']) {
        _memoryCache[key] = data;
        return data['value'] as T;
      }
      await prefs.remove(key);
    }
    
    return null;
  }

  Future<void> clearCache() async {
    _memoryCache.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  Future<void> removeItem(String key) async {
    _memoryCache.remove(key);
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}