import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'services/update_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SolarPanelApp());
}

class SolarPanelApp extends StatefulWidget {
  const SolarPanelApp({Key? key}) : super(key: key);

  @override
  _SolarPanelAppState createState() => _SolarPanelAppState();
}

class _SolarPanelAppState extends State<SolarPanelApp> {
  final UpdateService _updateService = UpdateService();

  @override
  void initState() {
    super.initState();
    _checkForUpdates();
  }

  void _checkForUpdates() async {
    // Ilovani ishga tushirganda yangilanishni tekshirish
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      _updateService.checkForUpdates(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quyosh Paneli Ma'lumotlari",
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
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
