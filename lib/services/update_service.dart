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

      final updateInfo = await _apiService.checkForUpdates(currentVersion);

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
      print('Yangilanish tekshirishda xatolik: $e');
    }
  }

  // Yangilanish dialogini ko'rsatish
  void _showUpdateDialog(BuildContext context, String version,
      String downloadUrl, String releaseNotes, bool isRequired) {
    showDialog(
      context: context,
      barrierDismissible: !isRequired,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
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
                child: Text('Keyinroq'),
              ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Bekor qilish'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _launchDownloadUrl(downloadUrl);
              },
              child: Text('Yuklab olish'),
            ),
          ],
        );
      },
    );
  }

  // Yuklab olish URL ni ochish
  Future<void> _launchDownloadUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
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
