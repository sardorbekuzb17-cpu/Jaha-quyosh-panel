import 'package:flutter/services.dart';

class NativeService {
  static const MethodChannel _channel = MethodChannel('quyosh24/native');

  // Qurilma ma'lumotlarini olish
  static Future<Map<String, String>?> getDeviceInfo() async {
    try {
      final result = await _channel.invokeMethod('getDeviceInfo');
      return Map<String, String>.from(result);
    } catch (e) {
      print('Qurilma ma\'lumotlarini olishda xato: $e');
      return null;
    }
  }

  // Ilova sozlamalarini ochish
  static Future<bool> openAppSettings() async {
    try {
      await _channel.invokeMethod('openAppSettings');
      return true;
    } catch (e) {
      print('Sozlamalarni ochishda xato: $e');
      return false;
    }
  }

  // APK o'rnatish
  static Future<bool> installApk(String filePath) async {
    try {
      await _channel.invokeMethod('installApk', {'filePath': filePath});
      return true;
    } catch (e) {
      print('APK o\'rnatishda xato: $e');
      return false;
    }
  }

  // Ilovani ulashish
  static Future<bool> shareApp() async {
    try {
      await _channel.invokeMethod('shareApp');
      return true;
    } catch (e) {
      print('Ilovani ulashishda xato: $e');
      return false;
    }
  }
}