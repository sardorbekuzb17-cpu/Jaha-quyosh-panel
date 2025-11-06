
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ErrorHandler {
  static void showError(BuildContext context, String message, {
    String? title, 
    VoidCallback? onRetry,
    bool showRetryButton = false
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Xatolik'),
        content: Text(message),
        actions: [
          if (showRetryButton && onRetry != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                onRetry();
              },
              child: const Text('Qayta urinish'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  static Future<void> handleApiError(BuildContext context, dynamic error) async {
    String message = 'Noma\'lum xatolik yuz berdi';
    bool showRetry = false;
    
    // Internet aloqasini tekshirish
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      message = 'Internet aloqasi mavjud emas';
      showRetry = true;
    } else if (error is TimeoutException) {
      message = 'So\'rov vaqti tugadi. Iltimos, qayta urinib ko\'ring';
      showRetry = true;
    } else if (error is Exception) {
      message = error.toString();
      showRetry = true;
    }
    
    showError(
      context, 
      message,
      showRetryButton: showRetry,
      onRetry: showRetry ? () => retryLastOperation(context) : null
    );
  }

  static Future<void> retryLastOperation(BuildContext context) async {
    // Oxirgi operatsiyani qayta bajarish logikasi
    try {
      // Retry logic implementation
    } catch (e) {
      handleApiError(context, e);
    }
  }

  // Log xatolarni saqlash
  static void logError(String error, StackTrace? stackTrace) {
    // Debug mode da console ga chiqarish
    debugPrint('Error: $error');
    if (stackTrace != null) {
      debugPrint('StackTrace: $stackTrace');
    }
    
    // TODO: Xatolarni serverga yuborish logikasini qo'shish
  }
}