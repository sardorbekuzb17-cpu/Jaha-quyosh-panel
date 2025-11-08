import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  static const String _updateUrl =
      'https://raw.githubusercontent.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/main/update.json';

  // Yangilanish ma'lumotlari
  static Future<UpdateInfo?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final response = await http.get(Uri.parse(_updateUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latestVersion = data['version'];

        if (_isNewerVersion(currentVersion, latestVersion)) {
          return UpdateInfo(
            version: latestVersion,
            downloadUrl: data['downloadUrl'],
            changelog: List<String>.from(data['changelog'] ?? []),
            isForced: data['isForced'] ?? false,
            minVersion: data['minVersion'] ?? '1.0.0',
          );
        }
      }
    } catch (e) {
      debugPrint('Yangilanish tekshirishda xato: $e');
    }
    return null;
  }

  // Versiya taqqoslash
  static bool _isNewerVersion(String current, String latest) {
    final currentParts = current.split('.').map(int.parse).toList();
    final latestParts = latest.split('.').map(int.parse).toList();

    for (int i = 0; i < 3; i++) {
      final currentPart = i < currentParts.length ? currentParts[i] : 0;
      final latestPart = i < latestParts.length ? latestParts[i] : 0;

      if (latestPart > currentPart) return true;
      if (latestPart < currentPart) return false;
    }
    return false;
  }

  // APK yuklab olish (demo uchun)
  static Future<String?> downloadApk(
      String url, Function(double) onProgress) async {
    try {
      // Demo progress simulation
      for (int i = 0; i <= 100; i += 10) {
        await Future.delayed(const Duration(milliseconds: 200));
        onProgress(i / 100.0);
      }

      // Demo: haqiqiy APK o'rniga test fayl yaratish
      final dir = await getExternalStorageDirectory();
      final filePath = '${dir!.path}/quyosh24_demo.txt';
      final file = File(filePath);
      await file.writeAsString('Demo APK fayl - test uchun');

      return filePath;
    } catch (e) {
      debugPrint('APK yuklab olishda xato: $e');
    }
    return null;
  }

  // APK o'rnatish (demo uchun)
  static Future<void> installApk(String filePath) async {
    try {
      // Demo: Google Play Store'ga yo'naltirish
      const playStoreUrl = 'https://play.google.com/store/apps';
      final uri = Uri.parse(playStoreUrl);
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('APK o\'rnatishda xato: $e');
    }
  }
}

class UpdateInfo {
  final String version;
  final String downloadUrl;
  final List<String> changelog;
  final bool isForced;
  final String minVersion;

  UpdateInfo({
    required this.version,
    required this.downloadUrl,
    required this.changelog,
    required this.isForced,
    required this.minVersion,
  });
}
