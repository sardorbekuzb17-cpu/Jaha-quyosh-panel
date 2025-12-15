import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Vercel server URL - Production
  static const String baseUrl =
      'https://server-4pvxwb66p-jaha-quyosh-panellaris-projects.vercel.app/api';
  static const Duration timeout = Duration(seconds: 15);

  // Generic HTTP client with error handling
  static Future<Map<String, dynamic>> _makeRequest(
    String endpoint, {
    String method = 'GET',
    Map<String, dynamic>? body,
    Map<String, String>? headers,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final defaultHeaders = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      };

      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response =
              await http.get(uri, headers: defaultHeaders).timeout(timeout);
          break;
        case 'POST':
          response = await http
              .post(
                uri,
                headers: defaultHeaders,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(timeout);
          break;
        case 'PUT':
          response = await http
              .put(
                uri,
                headers: defaultHeaders,
                body: body != null ? jsonEncode(body) : null,
              )
              .timeout(timeout);
          break;
        case 'DELETE':
          response =
              await http.delete(uri, headers: defaultHeaders).timeout(timeout);
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        final errorData = jsonDecode(response.body);
        throw ApiException(
          message: errorData['message'] ?? 'Unknown error',
          statusCode: response.statusCode,
        );
      }
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException(message: 'Network error: ${e.toString()}');
    }
  }

  // Health check - serverga ping
  static Future<Map<String, dynamic>> checkHealth() async {
    // /api/health endpoint orqali tekshirish
    final response = await _makeRequest('/health');
    return response;
  }

  // Panels
  static Future<List<Map<String, dynamic>>> getPanels({
    int page = 1,
    int limit = 10,
    String? search,
  }) async {
    String endpoint = '/panels?page=$page&limit=$limit';
    if (search != null && search.isNotEmpty) {
      endpoint += '&search=${Uri.encodeComponent(search)}';
    }

    final response = await _makeRequest(endpoint);
    return List<Map<String, dynamic>>.from(response['data']);
  }

  static Future<Map<String, dynamic>> getPanelById(String id) async {
    final response = await _makeRequest('/panels/$id');
    return response['data'];
  }

  static Future<Map<String, dynamic>> createPanel(
      Map<String, dynamic> panelData) async {
    final response =
        await _makeRequest('/panels', method: 'POST', body: panelData);
    return response['data'];
  }

  static Future<Map<String, dynamic>> updatePanel(
      String id, Map<String, dynamic> panelData) async {
    final response =
        await _makeRequest('/panels/$id', method: 'PUT', body: panelData);
    return response['data'];
  }

  static Future<void> deletePanel(String id) async {
    await _makeRequest('/panels/$id', method: 'DELETE');
  }

  // Inverters
  static Future<List<Map<String, dynamic>>> getInverters({
    int page = 1,
    int limit = 10,
    String? brand,
  }) async {
    String endpoint = '/inverters?page=$page&limit=$limit';
    if (brand != null && brand.isNotEmpty) {
      endpoint += '&brand=${Uri.encodeComponent(brand)}';
    }

    final response = await _makeRequest(endpoint);
    return List<Map<String, dynamic>>.from(response['data']);
  }

  static Future<Map<String, dynamic>> createInverter(
      Map<String, dynamic> inverterData) async {
    final response =
        await _makeRequest('/inverters', method: 'POST', body: inverterData);
    return response['data'];
  }

  // Modules
  static Future<List<Map<String, dynamic>>> getModules() async {
    final response = await _makeRequest('/modules');
    return List<Map<String, dynamic>>.from(response['data']);
  }

  // Contact
  static Future<Map<String, String>> getContact() async {
    final response = await _makeRequest('/contact');
    return Map<String, String>.from(response['data']);
  }

  static Future<Map<String, String>> updateContact(
      Map<String, String> contactData) async {
    final response =
        await _makeRequest('/contact', method: 'PUT', body: contactData);
    return Map<String, String>.from(response['data']);
  }

  // Ads
  static Future<List<Map<String, String>>> getAds() async {
    final response = await _makeRequest('/ads');
    return List<Map<String, String>>.from(response['data']);
  }

  // Calculator
  static Future<Map<String, dynamic>> calculateSolarSystem({
    required double monthlyBill,
    required double roofArea,
    String location = 'uzbekistan',
  }) async {
    final response = await _makeRequest('/calculate', method: 'POST', body: {
      'monthlyBill': monthlyBill,
      'roofArea': roofArea,
      'location': location,
    });
    return response['data'];
  }

  // Orders - Buyurtmalar
  static Future<List<Map<String, dynamic>>> getOrders() async {
    final response = await _makeRequest('/orders');
    return List<Map<String, dynamic>>.from(response['data'] ?? []);
  }

  static Future<Map<String, dynamic>> createOrder(
      Map<String, dynamic> orderData) async {
    final response =
        await _makeRequest('/orders', method: 'POST', body: orderData);
    return response['data'] ?? response;
  }

  static Future<Map<String, dynamic>> updateOrderStatus(
      String id, String status) async {
    final response = await _makeRequest('/orders/$id',
        method: 'PUT', body: {'status': status});
    return response['data'] ?? response;
  }

  static Future<void> deleteOrder(String id) async {
    await _makeRequest('/orders/$id', method: 'DELETE');
  }
}

// Custom exception class for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() =>
      'ApiException: $message${statusCode != null ? ' (Status: $statusCode)' : ''}';
}
