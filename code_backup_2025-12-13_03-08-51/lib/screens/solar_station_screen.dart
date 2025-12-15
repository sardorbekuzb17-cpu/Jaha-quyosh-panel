import 'package:flutter/material.dart';
import '../services/localization_service.dart';

class SolarStationScreen extends StatefulWidget {
  const SolarStationScreen({Key? key}) : super(key: key);

  @override
  _SolarStationScreenState createState() => _SolarStationScreenState();
}

class _SolarStationScreenState extends State<SolarStationScreen> {
  final List<Map<String, dynamic>> solarStations = [
    {
      'id': '1',
      'name': 'Kichik Quyosh Stansiyasi',
      'description': 'Uy va kichik biznes uchun ideal yechim. 10-50 kW quvvat.',
      'image_url': 'assets/images/solar_station/1.jpg',
      'power': '10-50 kW',
      'area': '100-500 m²',
      'price': '150,000,000 - 750,000,000 so\'m',
      'features': [
        'Avtomatik nazorat tizimi',
        'Remote monitoring',
        'Inverter va panellar',
        'Professional o\'rnatish',
        '25 yil kafolat'
      ]
    },
    {
      'id': '2',
      'name': 'O\'rta Quyosh Stansiyasi',
      'description':
          'Tijorat obyektlari va fabrikalar uchun. 100-500 kW quvvat.',
      'image_url': 'assets/images/solar_station/2.jpg',
      'power': '100-500 kW',
      'area': '1,000-5,000 m²',
      'price': '1,500,000,000 - 7,500,000,000 so\'m',
      'features': [
        'Smart grid integratsiya',
        'Energiya saqlash tizimi',
        'SCADA monitoring',
        'Avtomatik tozalash',
        '30 yil kafolat'
      ]
    },
    {
      'id': '3',
      'name': 'Katta Quyosh Stansiyasi',
      'description':
          'Sanoat komplekslari va shahar energetikasi uchun. 1-10 MW quvvat.',
      'image_url': 'assets/images/solar_station/3.jpg',
      'power': '1-10 MW',
      'area': '10,000-100,000 m²',
      'price': '15,000,000,000 - 150,000,000,000 so\'m',
      'features': [
        'Grid-tie inverterlar',
        'Meteorologik stansiya',
        'Transformer stansiyasi',
        'Xavfsizlik tizimlari',
        'Texnik xizmat markazi'
      ]
    },
    {
      'id': '4',
      'name': 'Mega Quyosh Stansiyasi',
      'description':
          'Davlat va yirik energetika loyihalari uchun. 10+ MW quvvat.',
      'image_url': 'assets/images/solar_station/4.jpg',
      'power': '10+ MW',
      'area': '100,000+ m²',
      'price': '150,000,000,000+ so\'m',
      'features': [
        'Markaziy nazorat tizimi',
        'Energiya savdo platformasi',
        'Qo\'shimcha xizmatlar',
        'Texnik ta\'lim markazi',
        'Tadqiqot laboratoriyasi'
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('solar_stations')),
        backgroundColor: Colors.orange[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange[700]!,
              Colors.orange[50]!,
            ],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: solarStations.length,
          itemBuilder: (context, index) {
            final station = solarStations[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 16),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rasm
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.asset(
                      station['image_url'],
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.solar_power,
                            size: 64,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nomi
                        Text(
                          station['name'],
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Tavsif
                        Text(
                          station['description'],
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Texnik ma'lumotlar
                        Row(
                          children: [
                            Expanded(
                              child: _buildInfoCard(
                                Icons.flash_on,
                                tr('power'),
                                station['power'],
                                Colors.blue,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: _buildInfoCard(
                                Icons.square_foot,
                                tr('area'),
                                station['area'],
                                Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Narx
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.orange[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.attach_money,
                                  color: Colors.orange[700]),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  '${tr('price')}: ${station['price']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.orange[700],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Xususiyatlar
                        Text(
                          tr('features'),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 8),

                        ...station['features'].map<Widget>((feature) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  size: 16,
                                  color: Colors.green[600],
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    feature,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),

                        const SizedBox(height: 16),

                        // Tugma
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              _showContactDialog(context, station);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[700],
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              tr('contact_for_project'),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      IconData icon, String title, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context, Map<String, dynamic> station) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr('contact_for_project')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${tr('project')}: ${station['name']}'),
            const SizedBox(height: 16),
            Text(tr('contact_info')),
            const SizedBox(height: 8),
            const Text('📞 +998 93 087 47 58'),
            const Text('📧 info@jahongroup.uz'),
            const Text('🌐 https://jahongroup.uz'),
            const Text('📱 @quyosh24_sun24'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(tr('ok')),
          ),
        ],
      ),
    );
  }
}
