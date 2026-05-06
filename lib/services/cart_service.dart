import 'dart:convert';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String name;
  final String type; // panel, inverter, modul, station
  final String imageUrl;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.type,
    required this.imageUrl,
    required this.price,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'type': type,
        'imageUrl': imageUrl,
        'price': price,
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        imageUrl: json['imageUrl'],
        price: (json['price'] as num).toDouble(),
        quantity: json['quantity'] ?? 1,
      );
}

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  factory CartService() => _instance;
  CartService._internal();

  static const String _cartKey = 'cart_items';
  static const String _hasNewOrderKey = 'has_new_order';
  List<CartItem> _items = [];
  bool _hasNewOrder = false;

  bool get hasNewOrder => _hasNewOrder;

  List<CartItem> get items => _items;
  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);
  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + (item.price * item.quantity));

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_cartKey);
    if (data != null) {
      final List<dynamic> jsonList = jsonDecode(data);
      _items = jsonList.map((json) => CartItem.fromJson(json)).toList();
    }
    _hasNewOrder = prefs.getBool(_hasNewOrderKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _items.map((item) => item.toJson()).toList();
    await prefs.setString(_cartKey, jsonEncode(jsonList));
  }

  void addItem(CartItem item) {
    final existingIndex =
        _items.indexWhere((i) => i.id == item.id && i.type == item.type);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(item);
    }
    _saveCart();
    notifyListeners();
  }

  void removeItem(String id, String type) {
    _items.removeWhere((item) => item.id == id && item.type == type);
    _saveCart();
    notifyListeners();
  }

  void updateQuantity(String id, String type, int quantity) {
    final index = _items.indexWhere((i) => i.id == id && i.type == type);
    if (index >= 0) {
      if (quantity <= 0) {
        _items.removeAt(index);
      } else {
        _items[index].quantity = quantity;
      }
      _saveCart();
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    _saveCart();
    notifyListeners();
  }

  bool isInCart(String id, String type) {
    return _items.any((item) => item.id == id && item.type == type);
  }

  // Yangi buyurtma indikatorini o'rnatish
  Future<void> setNewOrder(bool value) async {
    _hasNewOrder = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasNewOrderKey, value);
    notifyListeners();
  }

  // Yangi buyurtma indikatorini o'chirish
  Future<void> clearNewOrderIndicator() async {
    await setNewOrder(false);
  }

  // Buyurtma ID generatsiya qilish
  // Format: QUYOSH24-YYYYMMDD-HHMMSS-RANDOM
  // Misol: QUYOSH24-20260507-143025-A7B9C2
  String generateOrderId() {
    final now = DateTime.now();
    final dateStr =
        '${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
    final timeStr =
        '${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}';

    // Random 6 ta belgi (harflar va raqamlar)
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final randomStr = String.fromCharCodes(Iterable.generate(
        6, (_) => chars.codeUnitAt(random.nextInt(chars.length))));

    return 'QUYOSH24-$dateStr-$timeStr-$randomStr';
  }
}
