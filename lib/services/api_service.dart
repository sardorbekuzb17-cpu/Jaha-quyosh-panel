import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  static const String baseUrl = 'https://raw.githubusercontent.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/main/public'; // GitHub Raw
  late Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ));
  }

  // Internet ulanishini tekshirish
  Future<bool> hasInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  // Panel ma'lumotlarini olish
  Future<List<dynamic>> getPanels() async {
    try {
      if (!await hasInternetConnection()) {
        throw Exception('Internet aloqasi yo\'q');
      }

      final response = await _dio.get('/panels.json');
      return response.data['panels'] ?? [];
    } catch (e) {
      // Debug: Panel ma'lumotlarini olishda xatolik: $e
      return [];
    }
  }

  // Narxlarni olish
  Future<List<dynamic>> getPricing() async {
    try {
      if (!await hasInternetConnection()) {
        throw Exception('Internet aloqasi yo\'q');
      }

      final response = await _dio.get('/pricing');
      return response.data['pricing'] ?? [];
    } catch (e) {
      // Debug: Narx ma'lumotlarini olishda xatolik: $e
      return [];
    }
  }

  // Aloqa ma'lumotlarini olish
  Future<Map<String, dynamic>> getContactInfo() async {
    try {
      if (!await hasInternetConnection()) {
        throw Exception('Internet aloqasi yo\'q');
      }

      final response = await _dio.get('/contact.json');
      return response.data ?? {};
    } catch (e) {
      // Debug: Aloqa ma'lumotlarini olishda xatolik: $e
      return {};
    }
  }

  // Yangilanish ma'lumotlarini tekshirish
  Future<Map<String, dynamic>> checkForUpdates(String currentVersion) async {
    try {
      if (!await hasInternetConnection()) {
        throw Exception('Internet aloqasi yo\'q');
      }

      final response = await _dio.get('/version-check.json');
      print('Current: $currentVersion, Latest: ${response.data['latest_version']}');
      
      return response.data ?? {};
    } catch (e) {
      print('Yangilanish tekshirishda xatolik: $e');
      return {};
    }
  }

  // Foydalanuvchi statistikasini yuborish
  Future<void> sendUsageStats(Map<String, dynamic> stats) async {
    try {
      if (!await hasInternetConnection()) return;

      await _dio.post('/stats', data: stats);
    } catch (e) {
      // Debug: Statistika yuborishda xatolik: $e
    }
  }
}
