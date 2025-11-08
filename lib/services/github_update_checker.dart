import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:version/version.dart';

class GitHubUpdateChecker {
  final String githubRepo; // "username/reponame"
  final String currentVersion;
  
  GitHubUpdateChecker({required this.githubRepo, required this.currentVersion});
  
  factory GitHubUpdateChecker.fromPackageInfo({required String githubRepo}) {
    return GitHubUpdateChecker(
      githubRepo: githubRepo,
      currentVersion: '1.0.0', // Default, keyin package_info bilan almashtiramiz
    );
  }
  
  Future<Map<String, dynamic>?> checkForUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVer = packageInfo.version;
      
      final latestRelease = await getLatestRelease();
      if (latestRelease == null) return null;
      
      final latestVersion = latestRelease['tag_name']?.replaceAll('v', '') ?? '';
      final hasUpdate = _compareVersions(currentVer, latestVersion);
      
      return {
        'hasUpdate': hasUpdate,
        'latestVersion': latestVersion,
        'currentVersion': currentVer,
        'releaseNotes': latestRelease['body'],
        'downloadUrl': _getDownloadUrl(latestRelease),
        'release': latestRelease,
      };
    } catch (e) {
      // Debug: Update check error: $e
      return null;
    }
  }
  
  Future<Map<String, dynamic>?> getLatestRelease() async {
    final url = 'https://api.github.com/repos/$githubRepo/releases/latest';
    final response = await http.get(Uri.parse(url));
    
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    return null;
  }
  
  bool _compareVersions(String current, String latest) {
    try {
      final currentVersion = Version.parse(current);
      final latestVersion = Version.parse(latest);
      return latestVersion > currentVersion;
    } catch (e) {
      // Fallback: simple string comparison
      return latest.compareTo(current) > 0;
    }
  }
  
  String _getDownloadUrl(Map<String, dynamic> release) {
    // APK asset ni qidirish
    final assets = release['assets'] as List<dynamic>?;
    if (assets != null && assets.isNotEmpty) {
      for (final asset in assets) {
        final assetName = asset['name'] as String?;
        if (assetName?.toLowerCase().endsWith('.apk') == true) {
          return asset['browser_download_url'] as String;
        }
      }
    }
    
    // Agar APK topilmasa, release page ga yo'naltiramiz
    return release['html_url'] as String? ?? '';
  }
  
  Future<bool> launchDownload(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      return await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
    } catch (e) {
      // Debug: Download launch error: $e
      return false;
    }
  }
}