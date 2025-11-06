import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/order_model.dart';

class OrderService {
  static const String baseUrl = 'https://your-vercel-app.vercel.app';
  static const String cacheKey = 'cached_orders';

  // Buyurtma yuborish
  Future<bool> submitOrder(OrderModel order) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/api/orders'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode(order.toJson()),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Muvaffaqiyatli yuborildi
        await _saveOrderLocally(order);
        return true;
      } else {
        // Xatolik
        return false;
      }
    } catch (e) {
      print('Buyurtma yuborishda xatolik: $e');
      // Offline rejimda lokal saqlash
      await _saveOrderLocally(order);
      return false;
    }
  }

  // Lokal buyurtmalarni saqlash
  Future<void> _saveOrderLocally(OrderModel order) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final orders = await getLocalOrders();
      orders.add(order);

      final jsonString = json.encode(orders.map((o) => o.toJson()).toList());
      await prefs.setString(cacheKey, jsonString);
    } catch (e) {
      print('Lokal saqlashda xatolik: $e');
    }
  }

  // Lokal buyurtmalarni olish
  Future<List<OrderModel>> getLocalOrders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(cacheKey);

      if (jsonString != null) {
        final List<dynamic> data = json.decode(jsonString);
        return data.map((json) => OrderModel.fromJson(json)).toList();
      }
    } catch (e) {
      print('Lokal buyurtmalarni o\'qishda xatolik: $e');
    }

    return [];
  }
}
