import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'panels_screen.dart';
import 'inverters_screen.dart';
import 'pricing_screen.dart';
import 'contact_screen.dart';
import 'info_screen.dart';
import 'calculator_screen.dart';
import 'admin_login_screen.dart';
import '../services/update_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  bool _isOnline = true;
  final UpdateService _updateService = UpdateService();

  final List<Widget> _children = const [
    InfoScreen(),
    PanelsScreen(),
    InvertersScreen(),
    PricingScreen(),
    CalculatorScreen(),
    ContactScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
    _listenToConnectivity();
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
        title: const Text('Quyosh Paneli Ma\'lumotlari'),
        centerTitle: true,
        actions: [
          // Internet holati ko'rsatkichi
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isOnline ? Icons.wifi : Icons.wifi_off,
                  color: _isOnline ? Colors.green : Colors.red,
                  size: 20,
                ),
                const SizedBox(width: 4),
                Text(
                  _isOnline ? 'Online' : 'Offline',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isOnline ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          // Yangilanish tekshirish tugmasi
          IconButton(
            onPressed: () {
              _updateService.checkForUpdates(context, forceCheck: true);
            },
            icon: const Icon(Icons.system_update),
            tooltip: 'Yangilanishni tekshirish',
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
          // Yangilanish tugmasi
          IconButton(
            onPressed: () {
              _updateService.checkForUpdates(context, forceCheck: true);
            },
            icon: const Icon(Icons.system_update),
            tooltip: 'Yangilanishni tekshirish',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: _children[_currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue[900],
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
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
            icon: Icon(Icons.electrical_services),
            label: 'Inverterlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.price_change),
            label: 'Narxlar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Kalkulyator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_phone),
            label: 'Aloqa',
          ),
        ],
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
