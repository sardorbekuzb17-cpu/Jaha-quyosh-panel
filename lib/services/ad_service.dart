import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/solar_ad.dart';
import '../utils/cache_manager.dart';

class AdService {
  final String baseUrl = 'YOUR_API_URL';
  final CacheManager _cacheManager = CacheManager();

  // Barcha reklamalarni olish
  Future<List<SolarAd>> getAds({String? category}) async {
    try {
      final cacheKey = 'ads_${category ?? "all"}';
      
      // Keshdan tekshirish
      final cachedData = await _cacheManager.getData<List<dynamic>>(cacheKey);
      if (cachedData != null) {
        return cachedData
            .map((item) => SolarAd.fromJson(item as Map<String, dynamic>))
            .toList();
      }

      // Serverdan olish
      final response = await http.get(
        Uri.parse('$baseUrl/ads${category != null ? "?category=$category" : ""}'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final ads = data
            .map((item) => SolarAd.fromJson(item as Map<String, dynamic>))
            .toList();

        // Keshga saqlash
        await _cacheManager.setData(cacheKey, data);
        
        return ads;
      } else {
        throw Exception('Reklamalarni yuklashda xatolik yuz berdi');
      }
    } catch (e) {
      throw Exception('Reklamalarni yuklashda xatolik: $e');
    }
  }

  // Kategoriya bo'yicha reklamalarni olish
  Future<List<SolarAd>> getAdsByCategory(String category) {
    return getAds(category: category);
  }

  // Aktiv reklamalarni olish
  Future<List<SolarAd>> getActiveAds() async {
    final allAds = await getAds();
    final now = DateTime.now();
    
    return allAds.where((ad) => 
      ad.isActive && 
      ad.startDate.isBefore(now) && 
      ad.endDate.isAfter(now)
    ).toList();
  }
}