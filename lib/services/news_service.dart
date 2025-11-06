import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/news_model.dart';

class NewsService {
  static const String baseUrl = 'https://your-vercel-app.vercel.app';
  static const String cacheKey = 'cached_news';

  // Yangiliklar ro'yxatini olish
  Future<List<NewsModel>> getNews() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/news'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final news = data.map((json) => NewsModel.fromJson(json)).toList();

        // Keshga saqlash
        await _cacheNews(news);

        return news;
      } else {
        // Xatolik bo'lsa, keshdan o'qish
        return await _getCachedNews();
      }
    } catch (e) {
      print('Yangiliklar yuklashda xatolik: $e');
      return await _getCachedNews();
    }
  }

  // Keshga saqlash
  Future<void> _cacheNews(List<NewsModel> news) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = json.encode(news.map((n) => n.toJson()).toList());
      await prefs.setString(cacheKey, jsonString);
    } catch (e) {
      print('Keshga saqlashda xatolik: $e');
    }
  }

  // Keshdan o'qish
  Future<List<NewsModel>> _getCachedNews() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(cacheKey);

      if (jsonString != null) {
        final List<dynamic> data = json.decode(jsonString);
        return data.map((json) => NewsModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('Keshdan o\'qishda xatolik: $e');
    }

    return [];
  }
}
