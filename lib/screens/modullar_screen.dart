import 'package:flutter/material.dart';

class ModullarScreen extends StatelessWidget {
  const ModullarScreen({Key? key}) : super(key: key);

  final List<Map<String, String>> modullar = const [
    {
      'name': 'Solar Kabellar',
      'description': 'Qora va qizil solar kabellar - 4mm² va 6mm²',
      'image': 'assets/images/modullar/photo_2025-11-07_21-55-23.jpg',
      'type': 'Kabel',
      'spec': '4-6mm²',
    },
    {
      'name': 'MC4 Konnektorlar',
      'description': 'Suv o\'tkazmaydigan MC4 konnektorlar',
      'image': 'assets/images/modullar/photo_2025-11-07_21-55-24.jpg',
      'type': 'Konnektor',
      'spec': 'IP67',
    },
    {
      'name': 'LONGi Hi-MO X6 Panel',
      'description': 'Yuqori samaradorlikli quyosh paneli',
      'image': 'assets/images/modullar/photo_2025-11-07_21-55-25.jpg',
      'type': 'Panel',
      'spec': '565-585W',
    },
    {
      'name': 'Surge Protector (Qizil)',
      'description': 'CHT1-B40 himoya qurilmasi - 1000Vdc',
      'image': 'assets/images/modullar/photo_2025-11-07_21-55-25 (2).jpg',
      'type': 'Himoya',
      'spec': '1000Vdc',
    },
    {
      'name': 'DC Avtomat (Ko\'k)',
      'description': 'DZ47-63DC avtomatik himoya qurilmasi',
      'image': 'assets/images/modullar/photo_2025-11-07_21-55-25 (3).jpg',
      'type': 'Avtomat',
      'spec': 'C63',
    },
    {
      'name': 'Elektr Shkaf',
      'description': 'To\'liq jihozlangan elektr boshqaruv shkafi',
      'image': 'assets/images/modullar/photo_2025-11-07_23-00-32.jpg',
      'type': 'Shkaf',
      'spec': 'Professional',
    },
    {
      'name': 'Batareya Tizimi',
      'description': 'Felicity Solar batareya saqlash tizimi',
      'image': 'assets/images/modullar/photo_2025-11-07_23-00-43.jpg',
      'type': 'Batareya',
      'spec': 'Lithium',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 120,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: const Text(
                  'Quyosh Modullari',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF1E3A8A),
                        Color(0xFF3B82F6),
                        Color(0xFFFBBF24),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final modul = modullar[index];
                    return _buildModulCard(context, modul);
                  },
                  childCount: modullar.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulCard(BuildContext context, Map<String, String> modul) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () => _showModulDetails(context, modul),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Image.asset(
                  modul['image']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(
                        Icons.solar_power,
                        size: 64,
                        color: Colors.blue[700],
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      modul['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            modul['type']!,
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            modul['spec']!,
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showModulDetails(BuildContext context, Map<String, String> modul) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      modul['image']!,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          color: Colors.grey[200],
                          child: Icon(
                            Icons.solar_power,
                            size: 80,
                            color: Colors.blue[700],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    modul['name']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    modul['description']!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow('Turi', modul['type']!, Icons.category),
                  const SizedBox(height: 12),
                  _buildDetailRow(
                      'Spetsifikatsiya', modul['spec']!, Icons.info),
                  const SizedBox(height: 12),
                  _buildDetailRow('Kafolat', '2 yil', Icons.verified),
                  const SizedBox(height: 12),
                  _buildDetailRow('Sifat', 'Premium', Icons.star),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E3A8A)),
          const SizedBox(width: 16),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E3A8A),
            ),
          ),
        ],
      ),
    );
  }
}
