import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class DataService {
  static const String _panelsKey = 'panels_data';
  static const String _invertersKey = 'inverters_data';
  static const String _modulesKey = 'modules_data';
  static const String _contactKey = 'contact_data';
  static const String _adsKey = 'ads_data';

  // Panellar
  static Future<void> savePanels(List<Map<String, dynamic>> panels) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_panelsKey, jsonEncode(panels));
  }

  static Future<List<Map<String, dynamic>>> getPanels() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_panelsKey);
    if (data != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    }
    return _getDefaultPanels();
  }

  // Inverterlar
  static Future<void> saveInverters(List<Map<String, dynamic>> inverters) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_invertersKey, jsonEncode(inverters));
  }

  static Future<List<Map<String, dynamic>>> getInverters() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_invertersKey);
    if (data != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    }
    return _getDefaultInverters();
  }

  // Modullar
  static Future<void> saveModules(List<Map<String, dynamic>> modules) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modulesKey, jsonEncode(modules));
  }

  static Future<List<Map<String, dynamic>>> getModules() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_modulesKey);
    if (data != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(data));
    }
    return _getDefaultModules();
  }

  // Aloqa
  static Future<void> saveContact(Map<String, String> contact) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_contactKey, jsonEncode(contact));
  }

  static Future<Map<String, String>> getContact() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(_contactKey);
    if (data != null) {
      return Map<String, String>.from(jsonDecode(data));
    }
    return _getDefaultContact();
  }

  // Default ma'lumotlar
  static List<Map<String, dynamic>> _getDefaultPanels() {
    return [
      {
        'id': '1',
        'name': 'LONGi Hi-MO 5 5kW Tizim',
        'description': 'LONGi Hi-MO 5 seriyasi, 5kW tizim. Kichik uylar uchun ideal yechim.',
        'image_url': 'assets/images/panels/photo_2025-11-07_21-55-24.jpg',
        'power': 5000,
        'efficiency': 21.5,
        'warranty': '25 yil',
        'price': 45000000,
      },
      {
        'id': '2',
        'name': 'LONGi Hi-MO 6 10kW Tizim',
        'description': 'LONGi Hi-MO 6 seriyasi, 10kW to\'liq tizim. N-type TOPCon texnologiya.',
        'image_url': 'assets/images/panels/Longi_550w_copy.jpg',
        'power': 10000,
        'efficiency': 21.8,
        'warranty': '25 yil',
        'price': 80000000,
      },
    ];
  }

  static List<Map<String, dynamic>> _getDefaultInverters() {
    return [
      {
        'id': '1',
        'name': 'Huawei SUN2000-5KTL-M1',
        'brand': 'Huawei',
        'description': 'Yuqori samaradorlikka ega inverter, uy va kichik biznes uchun ideal.',
        'price': 8500000,
        'power': 5.0,
        'efficiency': '98.4%',
        'warranty': '10 yil',
        'type': 'Inverter',
        'features': ['Wi-Fi monitoring', 'Smart I-V diagnostika', 'AFCI himoya'],
        'imageUrl': 'assets/images/inverters/34062.jpg',
      },
    ];
  }

  static List<Map<String, dynamic>> _getDefaultModules() {
    return [
      {
        'id': '1',
        'name': 'LONGi Solar Hi-MO 6',
        'description': 'Yuqori samaradorlikka ega modul',
        'image_url': 'assets/images/modullar/photo_2025-11-07_21-55-24.jpg',
        'power': 550,
        'efficiency': 22.3,
        'price': 1200000,
      },
    ];
  }

  static Map<String, String> _getDefaultContact() {
    return {
      'phone': '+998 93 087 47 58',
      'telegram': 'https://t.me/quyosh24_sun24',
      'instagram': 'https://www.instagram.com/quyosh24_',
      'email': 'info@jahongroup.uz',
      'website': 'https://jahongroup.uz',
      'address': 'Navoiy viloyati, Uchquduq tumani, 13-A28',
      'services': 'Quyosh paneli o\'rnatish, texnik xizmat ko\'rsatish, konsultatsiya',
    };
  }
}