import 'package:flutter/material.dart';
import '../services/cart_service.dart';

class SolarStationScreen extends StatefulWidget {
  const SolarStationScreen({Key? key}) : super(key: key);

  @override
  _SolarStationScreenState createState() => _SolarStationScreenState();
}

class _SolarStationScreenState extends State<SolarStationScreen> {
  final List<Map<String, dynamic>> projects = [
    {
      'title': '5 kW Uy uchun',
      'subtitle': 'Kichik uy xo\'jaliklari uchun',
      'image': 'assets/images/solar_station/4.jpg',
      'power': '5 kW',
      'panels': '8 ta Longi 625W',
      'inverter': 'Deye 5kW',
      'warranty': '5 yil',
      'price': 28000000,
      'color': 0xFF4CAF50,
    },
    {
      'title': '10 kW Uy uchun',
      'subtitle': 'O\'rta uy xo\'jaliklari uchun',
      'image': 'assets/images/solar_station/3.jpg',
      'power': '10 kW',
      'panels': '16 ta Longi 625W',
      'inverter': 'Deye 10kW',
      'warranty': '5 yil',
      'price': 50000000,
      'color': 0xFF009688,
    },
    {
      'title': '20 kW Biznes',
      'subtitle': 'Kichik biznes uchun',
      'image': 'assets/images/solar_station/6.jpg',
      'power': '20 kW',
      'panels': '28 ta Jinko panel',
      'inverter': 'Diya invertor',
      'warranty': '5 yil',
      'price': 80000000,
      'color': 0xFF2196F3,
    },
    {
      'title': '30 kW Biznes',
      'subtitle': 'O\'rta biznes uchun',
      'image': 'assets/images/solar_station/2.jpg',
      'power': '30 kW',
      'panels': '46 ta Longi 650W',
      'inverter': 'Deye 30kW',
      'warranty': '5 yil',
      'price': 130000000,
      'color': 0xFF3F51B5,
    },
    {
      'title': '50 kW Korxona',
      'subtitle': 'Katta korxonalar uchun',
      'image': 'assets/images/solar_station/1.jpg',
      'power': '50 kW',
      'panels': '77 ta Longi 650W',
      'inverter': 'Sungrow invertor',
      'warranty': '5 yil',
      'price': 210000000,
      'color': 0xFF9C27B0,
    },
    {
      'title': '100 kW Sanoat',
      'subtitle': 'Sanoat ob\'ektlari uchun',
      'image': 'assets/images/solar_station/5.jpg',
      'power': '100 kW',
      'panels': '156 ta Longi 640W',
      'inverter': '2x Goodwe',
      'warranty': '5 yil',
      'price': 350000000,
      'color': 0xFFFF9800,
    },
    {
      'title': 'Mega Loyiha',
      'subtitle': '100 kW dan yuqori',
      'image': 'assets/images/solar_station/7.jpg',
      'power': '100+ kW',
      'panels': 'Buyurtmaga',
      'inverter': 'Professional',
      'warranty': '5 yil',
      'price': 0,
      'color': 0xFFF44336,
    },
  ];

  String _formatPrice(double price) {
    if (price == 0) return 'Kelishiladi';
    if (price >= 1000000) {
      return '${(price / 1000000).toStringAsFixed(0)} mln so\'m';
    }
    return '${price.toStringAsFixed(0)} so\'m';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1E3A8A), Color(0xFF3B82F6), Color(0xFFF8FAFC)],
            stops: [0.0, 0.2, 0.4],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Icon(Icons.solar_power,
                        size: 50, color: Colors.amber),
                    const SizedBox(height: 10),
                    const Text(
                      'Quyosh Stansiyalari',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Tayyor loyihalar va narxlar',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // Loyihalar ro'yxati
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    return _buildProjectCard(projects[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(Map<String, dynamic> project) {
    final Color color = Color(project['color'] as int);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Rasm - to'liq ko'rinadi
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: Image.asset(
                    project['image'],
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color.withValues(alpha: 0.8), color],
                          ),
                        ),
                        child: const Center(
                          child: Icon(Icons.solar_power,
                              size: 80, color: Colors.white54),
                        ),
                      );
                    },
                  ),
                ),
                // Quvvat badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.3),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      project['power'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Ma'lumotlar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Sarlavha
                Text(
                  project['title'],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  project['subtitle'],
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),

                const SizedBox(height: 16),

                // Spetsifikatsiyalar
                Row(
                  children: [
                    Expanded(
                        child:
                            _buildSpec(Icons.solar_power, project['panels'])),
                    Expanded(
                        child: _buildSpec(
                            Icons.electrical_services, project['inverter'])),
                  ],
                ),
                const SizedBox(height: 8),
                _buildSpec(
                    Icons.verified_user, '${project['warranty']} kafolat'),

                const SizedBox(height: 16),

                // Narx va Savat
                Row(
                  children: [
                    // Narx
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.amber[200]!),
                        ),
                        child: Center(
                          child: Text(
                            _formatPrice(project['price'].toDouble()),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Savat tugmasi
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _addToCart(project),
                        icon: const Icon(Icons.shopping_cart, size: 20),
                        label: const Text('Savatga'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpec(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.blue[700]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  void _addToCart(Map<String, dynamic> project) {
    CartService().addItem(CartItem(
      id: project['title'].hashCode.toString(),
      name: project['title'],
      type: 'Stansiya',
      imageUrl: project['image'],
      price: project['price'].toDouble(),
    ));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Text('${project['title']} savatga qo\'shildi'),
          ],
        ),
        backgroundColor: Colors.green[600],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
