import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymeService {
  // Payme konfiguratsiyasi - TEST MODE
  static const String _merchantId = '69d6d6113663bd982443630d';
  static const String _secretKey =
      '4EkYNKATgBk2tyBENNfCaAn&QPVRSGjP2FAj'; // Payme Test Secret Key

  // Checkout URL - TEST MODE
  static const String _checkoutBaseUrl = 'https://test.paycom.uz';

  // Backend API URL (sizning serveringiz)
  static const String _backendUrl = 'https://quyosh24.uz/api/payme';

  /// To'lov yaratish va Payme checkout URL olish
  ///
  /// [orderId] - Buyurtma ID (unikal bo'lishi kerak)
  /// [amount] - Summa so'mda
  /// [customerName] - Mijoz ismi
  /// [phone] - Mijoz telefon raqami (ixtiyoriy)
  ///
  /// Qaytaradi: {success, checkoutUrl, orderId, amount}
  static Future<Map<String, dynamic>> createPayment({
    required String orderId,
    required double amount,
    required String customerName,
    String? phone,
  }) async {
    try {
      // 1. Summani tiyinga o'tkazish (1 so'm = 100 tiyin)
      final amountInTiyin = (amount * 100).toInt();

      // 2. Minimal summa tekshirish (1000 so'm = 100000 tiyin)
      if (amountInTiyin < 100000) {
        return {
          'success': false,
          'error': 'Minimal to\'lov summasi 1000 so\'m',
        };
      }

      // 3. Payme checkout parametrlari
      final params = {
        'm': _merchantId, // Merchant ID
        'ac.order_id': orderId, // Buyurtma ID (account field)
        'a': amountInTiyin.toString(), // Summa (tiyinlarda)
        'l': 'uz', // Til (uz, ru, en)
      };

      // Telefon ixtiyoriy
      if (phone != null && phone.isNotEmpty) {
        params['c'] = phone;
      }

      // 4. Parametrlarni URL query string ga aylantirish
      final queryString = params.entries
          .map((e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');

      // 5. Base64 URL encode qilish
      final encodedParams = base64Url.encode(utf8.encode(queryString));

      // 6. Checkout URL yaratish
      final checkoutUrl = '$_checkoutBaseUrl/$encodedParams';

      return {
        'success': true,
        'checkoutUrl': checkoutUrl,
        'orderId': orderId,
        'amount': amount,
        'amountInTiyin': amountInTiyin,
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'To\'lov yaratishda xato: ${e.toString()}',
      };
    }
  }

  /// To'lov holatini tekshirish
  ///
  /// [orderId] - Buyurtma ID
  ///
  /// Qaytaradi: {success, status, orderId}
  /// status: pending, paid, cancelled
  static Future<Map<String, dynamic>> checkPaymentStatus(String orderId) async {
    try {
      // Backend API dan to'lov holatini so'rash
      final response = await http.get(
        Uri.parse('$_backendUrl/check-status?order_id=$orderId'),
        headers: {'Content-Type': 'application/json'},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return {
          'success': true,
          'status': data['status'] ?? 'pending',
          'orderId': orderId,
          'transaction': data['transaction'],
        };
      } else {
        return {
          'success': false,
          'error': 'Server xatosi: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Xato: ${e.toString()}',
      };
    }
  }

  /// Payme test to'lovini amalga oshirish
  /// (Faqat test muhitida ishlaydi)
  static Future<Map<String, dynamic>> performTestPayment({
    required String orderId,
    required double amount,
  }) async {
    try {
      // Test muhitida to'lovni avtomatik tasdiqlash
      await Future.delayed(const Duration(seconds: 2));

      return {
        'success': true,
        'status': 'paid',
        'orderId': orderId,
        'message': 'Test to\'lov muvaffaqiyatli amalga oshirildi',
      };
    } catch (e) {
      return {
        'success': false,
        'error': e.toString(),
      };
    }
  }

  /// Payme merchant ID va key ni tekshirish
  static bool isConfigured() {
    return _merchantId.isNotEmpty &&
        _merchantId != 'YOUR_MERCHANT_ID' &&
        _merchantId != 'YOUR_REAL_MERCHANT_ID';
  }

  /// Test yoki production muhitini aniqlash
  static bool isTestMode() {
    return _checkoutBaseUrl.contains('test');
  }

  /// Merchant ID ni olish (faqat debug uchun)
  static String getMerchantId() {
    return _merchantId;
  }
}
