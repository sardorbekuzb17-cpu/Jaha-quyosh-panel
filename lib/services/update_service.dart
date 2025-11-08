import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'native_service.dart';

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
            releaseNotes: data['releaseNotes'],
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

  // APK yuklab olish (GitHub'dan)
  static Future<String?> downloadApk(
      String url, Function(double) onProgress) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getExternalStorageDirectory();
        final filePath = '${dir!.path}/quyosh24_v2.0.0.apk';
        final file = File(filePath);
        
        // Progress simulation
        for (int i = 0; i <= 100; i += 5) {
          await Future.delayed(const Duration(milliseconds: 50));
          onProgress(i / 100.0);
        }
        
        await file.writeAsBytes(bytes);
        return filePath;
      }
    } catch (e) {
      debugPrint('APK yuklab olishda xato: $e');
      // Agar GitHub'dan yuklab olmasa, brauzerda ochish
      await _openInBrowser(url);
    }
    return null;
  }

  // APK o'rnatish yoki brauzerda ochish
  static Future<void> installApk(String? filePath) async {
    try {
      if (filePath != null && await File(filePath).exists()) {
        // Native Android orqali APK o'rnatish
        final success = await NativeService.installApk(filePath);
        if (success) {
          debugPrint('APK o\'rnatish boshlandi: $filePath');
          return;
        }
      }
      
      // Agar native o'rnatish ishlamasa, GitHub sahifasini ochish
      const githubUrl = 'https://github.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/releases';
      await _openInBrowser(githubUrl);
    } catch (e) {
      debugPrint('APK o\'rnatishda xato: $e');
      // Xato bo'lsa ham GitHub sahifasini ochish
      const githubUrl = 'https://github.com/sardorbekuzb17-cpu/Jaha-quyosh-panel/releases';
      await _openInBrowser(githubUrl);
    }
  }
  
  // Brauzerda ochish
  static Future<void> _openInBrowser(String url) async {
    final uri = Uri.parse(url);
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class UpdateInfo {
  final String version;
  final String downloadUrl;
  final List<String> changelog;
  final bool isForced;
  final String minVersion;
  final String? releaseNotes;

  UpdateInfo({
    required this.version,
    required this.downloadUrl,
    required this.changelog,
    required this.isForced,
    required this.minVersion,
    this.releaseNotes,
  });
}
