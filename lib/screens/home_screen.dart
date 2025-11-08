import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'panels_screen.dart';
import 'inverters_screen.dart';
import 'modullar_screen.dart';
import 'contact_screen.dart';
import 'info_screen.dart';
import 'admin_login_screen.dart';

import 'license_screen.dart';
import '../services/update_service.dart';
import '../widgets/update_dialog_pro.dart';
import '../services/native_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _currentIndex = 0;
  bool _isOnline = true;
  late AnimationController _rotationController;
  late AnimationController _colorController;

  final List<Widget> _children = const [
    InfoScreen(),
    PanelsScreen(),
    ModullarScreen(),
    InvertersScreen(),
    ContactScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _listenToConnectivity();

    // Siljish animatsiyasi
    _rotationController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    // Rang animatsiyasi
    _colorController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _checkConnectivity() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _isOnline = connectivityResult != ConnectivityResult.none;
    });
  }

  void _listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });
    });
  }

  void onTappedBar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        title: ClipRect(
          child: AnimatedBuilder(
            animation:
                Listenable.merge([_rotationController, _colorController]),
            builder: (context, child) {
              // O'ngdan chapga siljish, keyin yana o'ngdan boshlanish
              double screenWidth = 600;
              double textWidth = 600;
              double position = screenWidth +
                  textWidth -
                  (_rotationController.value * (screenWidth + textWidth * 2));

              // RGB rang animatsiyasi - to'xtovsiz o'zgarib turadi
              Color textColor = Color.lerp(
                Color.lerp(Colors.red, Colors.green, _colorController.value)!,
                Color.lerp(Colors.blue, Colors.purple, _colorController.value)!,
                (_colorController.value * 3) % 1,
              )!;

              return Transform.translate(
                offset: Offset(position, 0),
                child: Text(
                  "JAHON GROUP QUYOSH STANSIYASI O'RNATISH",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    letterSpacing: 1.5,
                    color: textColor,
                    shadows: [
                      Shadow(
                        color: textColor.withValues(alpha: 0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E3A8A), // Quyuq ko'k
                Color(0xFF3B82F6), // Ko'k
                Color(0xFFFBBF24), // Oltin
              ],
            ),
          ),
        ),
        elevation: 8,
        shadowColor: Colors.black26,
        actions: [
          // Yangilanish tekshirish tugmasi
          IconButton(
            onPressed: () async {
              final updateInfo = await UpdateService.checkForUpdate();
              if (updateInfo != null) {
                showDialog(
                  context: context,
                  barrierDismissible: !updateInfo.isForced,
                  builder: (context) => UpdateDialogPro(updateInfo: updateInfo),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('✅ Siz eng so\'nggi versiyadan foydalanmoqdasiz'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
            },
            icon: const Icon(Icons.system_update),
            tooltip: 'Yangilanish tekshirish',
          ),
          // Litsenziya tugmasi
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const LicenseScreen()),
              );
            },
            icon: const Icon(Icons.info_outline),
            tooltip: 'Litsenziya',
          ),
          // Qurilma ma'lumotlari tugmasi
          IconButton(
            onPressed: () async {
              final deviceInfo = await NativeService.getDeviceInfo();
              if (deviceInfo != null) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Qurilma Ma\'lumotlari'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Model: ${deviceInfo['model']}'),
                        Text('Ishlab chiqaruvchi: ${deviceInfo['manufacturer']}'),
                        Text('Android versiya: ${deviceInfo['version']}'),
                        Text('SDK: ${deviceInfo['sdk']}'),
                        Text('Brand: ${deviceInfo['brand']}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Yopish'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          NativeService.shareApp();
                        },
                        child: const Text('Ulashish'),
                      ),
                    ],
                  ),
                );
              }
            },
            icon: const Icon(Icons.phone_android),
            tooltip: 'Qurilma Ma\'lumotlari',
          ),
          // Admin panel tugmasi
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const AdminLoginScreen()),
              );
            },
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'Admin Panel',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC),
              Color(0xFFE2E8F0),
              Colors.white,
            ],
            stops: [0.0, 0.3, 1.0],
          ),
        ),
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF8FAFC),
              Colors.white,
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTappedBar,
          currentIndex: _currentIndex,
          selectedItemColor: const Color(0xFF1E3A8A),
          unselectedItemColor: Colors.grey[600],
          backgroundColor: Colors.transparent,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Bosh sahifa',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.solar_power),
              label: 'Panellar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.view_module),
              label: 'Modullar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.electrical_services),
              label: 'Inverterlar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.contact_phone),
              label: 'Aloqa',
            ),
          ],
        ),
      ),
      // Offline holatda xabar ko'rsatish
      bottomSheet: !_isOnline
          ? Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: Colors.orange,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.warning, color: Colors.white, size: 16),
                  SizedBox(width: 8),
                  Text(
                    'Internet aloqasi yo\'q - Offline rejimda ishlayapti',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
