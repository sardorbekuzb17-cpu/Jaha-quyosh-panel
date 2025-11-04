import 'package:flutter/material.dart';
import '../models/panel_model.dart';
import '../services/api_service.dart';

class PanelsScreen extends StatefulWidget {
  const PanelsScreen({Key? key}) : super(key: key);

  @override
  _PanelsScreenState createState() => _PanelsScreenState();
}

class _PanelsScreenState extends State<PanelsScreen> {
  final ApiService _apiService = ApiService();
  List<PanelModel> _panels = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPanels();
  }

  Future<void> _loadPanels() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final panelsData = await _apiService.getPanels();
      final panels =
          panelsData.map((data) => PanelModel.fromJson(data)).toList();

      setState(() {
        _panels = panels;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ma\'lumotlarni yuklashda xatolik: $e';
        _isLoading = false;
      });

      // Offline ma'lumotlarni yuklash
      _loadOfflineData();
    }
  }

  void _loadOfflineData() {
    // Professional quyosh paneli ma'lumotlari
    final offlinePanels = [
      PanelModel(
        id: '1',
        name: 'Jinko Solar Monokristalin Panel',
        description:
            'Klass A, Tier 1 - Monokristalin texnologiya, 715W quvvat, KPD 23%',
        imageUrl: 'assets/images/jinko_mono.jpg',
        power: 715.0,
        efficiency: 23.0,
        warranty: '25 yil mahsulot kafolati',
        price: 1162500.0, // 81,331,250 / 70 dona
        features: [
          'Jinko Solar brendi',
          'Klass A sifat',
          'Tier 1 ishlab chiqaruvchi',
          'Monokristalin texnologiya',
          'Yuqori KPD 23%',
          '25 yil kafolat',
          'Ob-havo bardoshli'
        ],
      ),
      PanelModel(
        id: '2',
        name: 'DEYE Setevoy Invertor',
        description: '50 kVt, 3 fazali setevoy invertor, KPD 98.6%',
        imageUrl: 'assets/images/deye_inverter.jpg',
        power: 50000.0,
        efficiency: 98.6,
        warranty: '10 yil kafolat',
        price: 25625000.0,
        features: [
          'DEYE brendi',
          '3 fazali tizim',
          'Yuqori KPD 98.6%',
          'Setevoy ulanish',
          'MPPT nazorat',
          'Wi-Fi monitoring',
          'IP65 himoya darajasi'
        ],
      ),
      PanelModel(
        id: '3',
        name: 'Elektromontaj Prinajlejnosti',
        description:
            'Ikki qatlamli PV kabel, avtomat, nakonechniklar va boshqa jihozlar',
        imageUrl: 'assets/images/electrical_kit.jpg',
        power: 0.0,
        efficiency: 0.0,
        warranty: '5 yil kafolat',
        price: 5000000.0, // Taxminiy narx
        features: [
          'Ikki qatlamli PV kabel',
          'Avtomatik uzgichlar',
          'Nakonechniklar',
          'Ulagichlar',
          'Himoya qurilmalari',
          'Sertifikatlangan',
          'Xavfsizlik standartlari'
        ],
      ),
      PanelModel(
        id: '4',
        name: 'Opornaya Konstruksiya',
        description: 'Mustahkam metall konstruksiya va o\'rnatish ishlari',
        imageUrl: 'assets/images/mounting_system.jpg',
        power: 0.0,
        efficiency: 0.0,
        warranty: '20 yil konstruksiya kafolati',
        price: 8000000.0, // Taxminiy narx
        features: [
          'Galvanizlangan po\'lat',
          'Shamol bardoshli',
          'Qor yuki hisobida',
          'Oson o\'rnatish',
          'Uzoq muddatli',
          'Korroziyaga chidamli',
          'Sertifikatlangan'
        ],
      ),
      PanelModel(
        id: '5',
        name: 'To\'liq O\'rnatish Xizmati',
        description: 'Yetkazib berish, o\'rnatish, sozlash va ishga tushirish',
        imageUrl: 'assets/images/installation_service.jpg',
        power: 0.0,
        efficiency: 0.0,
        warranty: '2 yil ish kafolati',
        price: 15000000.0, // Taxminiy narx
        features: [
          'Professional jamoa',
          'Yetkazib berish',
          'O\'rnatish ishlari',
          'Tizimni sozlash',
          'Ishga tushirish',
          'Ta\'lim berish',
          'Texnik qo\'llab-quvvatlash'
        ],
      ),
      PanelModel(
        id: '6',
        name: 'Loyihalash Xizmati',
        description: 'Quyosh paneli tizimini loyihalash va hisob-kitoblar',
        imageUrl: 'assets/images/design_service.jpg',
        power: 0.0,
        efficiency: 0.0,
        warranty: '1 yil loyiha kafolati',
        price: 3000000.0,
        features: [
          '3D modellashtirish',
          'Energiya hisob-kitobi',
          'Texnik hujjatlar',
          'Ruxsatnomalar',
          'Optimallashtirish',
          'Iqtisodiy tahlil',
          'Konsultatsiya'
        ],
      ),
    ];

    setState(() {
      _panels = offlinePanels;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadPanels,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quyosh Paneli Turlari',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  IconButton(
                    onPressed: _loadPanels,
                    icon: Icon(Icons.refresh, color: Colors.blue[900]),
                    tooltip: 'Yangilash',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Turli xil quyosh paneli turlari va ularning xususiyatlari bilan tanishing',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 20),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Offline rejimda ishlayapti. Internet ulanishini tekshiring.',
                          style: TextStyle(color: Colors.orange[800]),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _panels.length,
                  itemBuilder: (context, index) {
                    return _buildPanelCard(_panels[index]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPanelCard(PanelModel panel) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.solar_power,
                      color: Colors.blue[900], size: 30),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        panel.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        panel.description,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildInfoChip('${panel.power.toInt()}W', Icons.flash_on),
                const SizedBox(width: 8),
                _buildInfoChip('${panel.efficiency}%', Icons.trending_up),
                const SizedBox(width: 8),
                _buildInfoChip(panel.warranty, Icons.verified_user),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: panel.features
                  .map(
                    (feature) => Chip(
                      label:
                          Text(feature, style: const TextStyle(fontSize: 12)),
                      backgroundColor: Colors.blue[50],
                      labelStyle: TextStyle(color: Colors.blue[800]),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${panel.price.toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[700],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Batafsil ma'lumot yoki buyurtma berish
                  },
                  child: const Text('Batafsil'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(String label, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
