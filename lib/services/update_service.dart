import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'api_service.dart';

class UpdateService {
  static const String _lastCheckKey = 'last_update_check';
  static const String _skipVersionKey = 'skip_version';

  final ApiService _apiService = ApiService();

  // Yangilanishni tekshirish
  Future<void> checkForUpdates(BuildContext context,
      {bool forceCheck = false}) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final now = DateTime.now().millisecondsSinceEpoch;
      final lastCheck = prefs.getInt(_lastCheckKey) ?? 0;

      // Har 24 soatda bir marta tekshirish (majburiy emas bo'lsa)
      if (!forceCheck && (now - lastCheck) < 86400000) {
        return;
      }

      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      // Demo: Yangilanish simulyatsiyasi
      // Haqiqiy loyihada bu GitHub API yoki boshqa server API dan keladi
      final updateInfo = await _checkForUpdatesDemo(currentVersion);

      if (updateInfo.isNotEmpty) {
        final latestVersion = updateInfo['latest_version'];
        final isRequired = updateInfo['is_required'] ?? false;
        final downloadUrl = updateInfo['download_url'];
        final releaseNotes = updateInfo['release_notes'] ?? '';

        final skippedVersion = prefs.getString(_skipVersionKey);

        if (latestVersion != currentVersion &&
            (isRequired || skippedVersion != latestVersion)) {
          _showUpdateDialog(
              context, latestVersion, downloadUrl, releaseNotes, isRequired);
        }
      }

      // Oxirgi tekshirish vaqtini saqlash
      await prefs.setInt(_lastCheckKey, now);
    } catch (e) {
      // Debug: Yangilanish tekshirishda xatolik: $e
    }
  }

  // Demo yangilanish tekshiruvi
  Future<Map<String, dynamic>> _checkForUpdatesDemo(
      String currentVersion) async {
    // Simulyatsiya: 2 soniya kutish
    await Future.delayed(const Duration(seconds: 2));

    // Faqat versiya 1.0.0 bo'lsa yangilanish ko'rsatish
    if (currentVersion == '1.0.0') {
      return {
        'latest_version': '1.1.0',
        'is_required': false,
        'download_url':
            'https://github.com/your-username/solar-panel-app/releases/latest',
        'release_notes': '''Yangi xususiyatlar:
• Inverterlar bo'limi qo'shildi
• Real panel modellari qo'shildi  
• Yangilanish tizimi yaxshilandi
• Interfeys tezligi oshirildi
• Xatolar tuzatildi

Ushbu yangilanish tavsiya etiladi!'''
      };
    }

    // Yangilanish yo'q
    return {};
  }

  // Yangilanish dialogini ko'rsatish
  void _showUpdateDialog(BuildContext context, String version,
      String downloadUrl, String releaseNotes, bool isRequired) {
    showDialog(
      context: context,
      barrierDismissible: !isRequired,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.system_update, color: Colors.blue),
              SizedBox(width: 10),
              Text('Yangilanish mavjud'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Yangi versiya: $version'),
              SizedBox(height: 10),
              if (releaseNotes.isNotEmpty) ...[
                Text('Yangiliklar:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text(releaseNotes),
                SizedBox(height: 10),
              ],
              if (isRequired)
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.red, size: 16),
                      SizedBox(width: 5),
                      Expanded(
                          child: Text('Bu yangilanish majburiy!',
                              style:
                                  TextStyle(color: Colors.red, fontSize: 12))),
                    ],
                  ),
                ),
            ],
          ),
          actions: [
            if (!isRequired)
              TextButton(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.setString(_skipVersionKey, version);
                  Navigator.of(context).pop();
                },
                child: const Text('Keyinroq'),
              ),
            if (!isRequired)
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Bekor qilish'),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _launchDownloadUrl(downloadUrl);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('Yuklab olish'),
            ),
          ],
        );
      },
    );
  }

  // Yuklab olish URL ni ochish
  Future<void> _launchDownloadUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // Majburiy yangilanishni tekshirish
  Future<bool> isForceUpdateRequired() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      final updateInfo = await _apiService.checkForUpdates(currentVersion);

      if (updateInfo.isNotEmpty) {
        final latestVersion = updateInfo['latest_version'];
        final isRequired = updateInfo['is_required'] ?? false;

        return isRequired && latestVersion != currentVersion;
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
