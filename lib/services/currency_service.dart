import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CurrencyService {
  static const String _cbuApiUrl =
      'https://cbu.uz/uz/arkhiv-kursov-valyut/json/';
  final Dio _dio = Dio();

  // Cached exchange rate
  static double _cachedUsdRate = 12700.0; // Default rate
  static DateTime? _lastUpdate;

  // Dollar kursini olish
  Future<double> getUsdRate() async {
    // Agar 1 soatdan kam vaqt o'tgan bo'lsa, cache'dan qaytaramiz
    if (_lastUpdate != null &&
        DateTime.now().difference(_lastUpdate!).inHours < 1) {
      return _cachedUsdRate;
    }

    try {
      final response = await _dio.get(_cbuApiUrl);

      if (response.statusCode == 200 && response.data is List) {
        // USD kursini topamiz (kod: USD)
        final usdData = (response.data as List).firstWhere(
          (currency) => currency['Ccy'] == 'USD',
          orElse: () => null,
        );

        if (usdData != null) {
          final rate = double.parse(usdData['Rate'].toString());
          _cachedUsdRate = rate;
          _lastUpdate = DateTime.now();
          return rate;
        }
      }
    } catch (e) {
      debugPrint('Dollar kursini olishda xatolik: $e');
    }

    // Xatolik bo'lsa, cached rate'ni qaytaramiz
    return _cachedUsdRate;
  }

  // USD'dan UZS'ga o'tkazish
  Future<double> usdToUzs(double usdAmount) async {
    final rate = await getUsdRate();
    return usdAmount * rate;
  }

  // UZS'dan USD'ga o'tkazish
  Future<double> uzsToUsd(double uzsAmount) async {
    final rate = await getUsdRate();
    return uzsAmount / rate;
  }

  // Formatlangan narxni qaytarish
  Future<String> formatPrice(double usdPrice) async {
    final uzsPrice = await usdToUzs(usdPrice);
    final millions = (uzsPrice / 1000000).toStringAsFixed(1);
    return '$millions M so\'m';
  }

  // Cached rate'ni olish (offline uchun)
  double getCachedRate() {
    return _cachedUsdRate;
  }
}
