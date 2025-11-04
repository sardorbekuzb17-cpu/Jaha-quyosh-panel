import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ApiService {
  static const String baseUrl =
      'https://solar-panel-app.vercel.app/api'; // Bu yerga Vercel URL ni qo'ying
  late Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
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

      final response = await _dio.get('/panels');
      return response.data['panels'] ?? [];
    } catch (e) {
      print('Panel ma\'lumotlarini olishda xatolik: $e');
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
      print('Narx ma\'lumotlarini olishda xatolik: $e');
      return [];
    }
  }

  // Aloqa ma'lumotlarini olish
  Future<Map<String, dynamic>> getContactInfo() async {
    try {
      if (!await hasInternetConnection()) {
        throw Exception('Internet aloqasi yo\'q');
      }

      final response = await _dio.get('/contact');
      return response.data ?? {};
    } catch (e) {
      print('Aloqa ma\'lumotlarini olishda xatolik: $e');
      return {};
    }
  }

  // Yangilanish ma'lumotlarini tekshirish
  Future<Map<String, dynamic>> checkForUpdates(String currentVersion) async {
    try {
      if (!await hasInternetConnection()) {
        throw Exception('Internet aloqasi yo\'q');
      }

      final response = await _dio.get('/version-check',
          queryParameters: {'current_version': currentVersion});
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
      print('Statistika yuborishda xatolik: $e');
    }
  }
}
