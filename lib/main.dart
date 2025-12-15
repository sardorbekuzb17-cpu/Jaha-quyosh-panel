import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/splash_screen.dart';
import 'services/update_service.dart';
import 'services/cache_service.dart';
import 'services/connectivity_service.dart';
import 'widgets/update_dialog_pro.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cache va connectivity servislarini ishga tushirish
  try {
    await CacheService.initialize();
    await ConnectivityService().initialize();
  } catch (e) {
    debugPrint('Servislarni ishga tushirishda xato: $e');
  }

  runApp(const SolarPanelApp());
}

class SolarPanelApp extends StatefulWidget {
  const SolarPanelApp({Key? key}) : super(key: key);

  @override
  _SolarPanelAppState createState() => _SolarPanelAppState();
}

class _SolarPanelAppState extends State<SolarPanelApp> {
  @override
  void initState() {
    super.initState();
    _checkForUpdateOnStart();
  }

  Future<void> _checkForUpdateOnStart() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      await _checkForUpdate();
    }
  }

  Future<void> _checkForUpdate() async {
    try {
      final updateInfo = await UpdateService.checkForUpdate();
      if (updateInfo != null && mounted) {
        showDialog(
          context: context,
          barrierDismissible: !updateInfo.isForced,
          builder: (context) => UpdateDialogPro(updateInfo: updateInfo),
        );
      }
    } catch (e) {
      debugPrint('Yangilanish tekshirishda xato: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quyosh24 - Quyosh Energiyasi Yechimlari",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[900],
          foregroundColor: Colors.white,
          elevation: 2,
        ),
      ),
      // O'zbek tili qo'llab-quvvatlashi
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('uz', 'UZ'), // O'zbek tili
        Locale('en', 'US'), // Ingliz tili (zaxira)
      ],
      locale: const Locale('uz', 'UZ'), // Asosiy til o'zbek
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
