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

  // Real yangilanish tekshiruvi
  Future<Map<String, dynamic>> _checkForUpdatesDemo(
      String currentVersion) async {
    try {
      final updateInfo = await _apiService.checkForUpdates(currentVersion);
      
      if (updateInfo.isNotEmpty) {
        final latestVersion = updateInfo['latest_version'];
        
        // Versiyalarni string sifatida taqqoslash
        if (latestVersion.toString() != currentVersion.toString()) {
          return {
            'latest_version': latestVersion.toString(),
            'is_required': updateInfo['force_update'] ?? false,
            'download_url': updateInfo['download_url'].toString(),
            'release_notes': updateInfo['changelog']?.toString() ?? 'Yangilanish mavjud'
          };
        }
      }
    } catch (e) {
      // Xatolik bo'lsa yangilanish yo'q
    }
    
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
              const SizedBox(height: 10),
              if (releaseNotes.isNotEmpty) ...[
                const Text('Yangiliklar:',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(releaseNotes),
                const SizedBox(height: 10),
              ],
              if (isRequired)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Row(
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
              onPressed: () async {
                Navigator.of(context).pop();
                await _launchDownloadUrl(downloadUrl);
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

  // APK avtomatik yuklab olish
  Future<void> _launchDownloadUrl(String url) async {
    try {
      // Avtomatik yuklab olish uchun direct download link
      final Uri uri = Uri.parse('https://drive.google.com/uc?export=download&id=1iaYH47qIoL9qe5wfj-IeeovQIbMoS_Km');
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (e) {
      // Xatolik bo'lsa oddiy link
      final Uri uri = Uri.parse(url);
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
