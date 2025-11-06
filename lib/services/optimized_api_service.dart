import 'package:dio/dio.dart';
import '../utils/cache_manager.dart';

class OptimizedApiService {
  static final OptimizedApiService _instance = OptimizedApiService._internal();
  factory OptimizedApiService() => _instance;
  
  final Dio _dio = Dio();
  final CacheManager _cacheManager = CacheManager();
  
  OptimizedApiService._internal() {
    _dio.options.baseUrl = 'YOUR_API_BASE_URL';
    _dio.options.connectTimeout = const Duration(seconds: 5);
    _dio.options.receiveTimeout = const Duration(seconds: 3);
    
    // Interceptors for optimization
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Check cache first
        final cachedData = await _cacheManager.getData<dynamic>(options.path);
        if (cachedData != null) {
          return handler.resolve(
            Response(
              requestOptions: options,
              data: cachedData,
              statusCode: 200,
            ),
          );
        }
        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // Cache successful responses
        if (response.statusCode == 200) {
          await _cacheManager.setData(
            response.requestOptions.path,
            response.data,
          );
        }
        return handler.next(response);
      },
    ));
  }

  Future<dynamic> get(String path, {
    Map<String, dynamic>? queryParameters,
    bool forceRefresh = false,
  }) async {
    if (forceRefresh) {
      await _cacheManager.removeItem(path);
    }
    
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        return TimeoutException('So\'rov vaqti tugadi');
      case DioErrorType.badResponse:
        return Exception('Server xatosi: ${error.response?.statusCode}');
      default:
        return Exception('Xatolik yuz berdi: ${error.message}');
    }
  }
}