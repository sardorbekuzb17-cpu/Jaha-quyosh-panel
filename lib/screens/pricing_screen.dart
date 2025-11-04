import 'package:flutter/material.dart';
import '../models/panel_model.dart';
import '../services/api_service.dart';

class PricingScreen extends StatefulWidget {
  const PricingScreen({Key? key}) : super(key: key);

  @override
  _PricingScreenState createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  final ApiService _apiService = ApiService();
  List<PricingModel> _pricingPackages = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPricing();
  }

  Future<void> _loadPricing() async {
    setState(() => _isLoading = true);

    try {
      final pricingData = await _apiService.getPricing();
      final packages =
          pricingData.map((data) => PricingModel.fromJson(data)).toList();

      setState(() {
        _pricingPackages = packages;
        _isLoading = false;
      });
    } catch (e) {
      // Offline ma'lumotlar
      _loadOfflinePricing();
    }
  }

  void _loadOfflinePricing() {
    final offlinePackages = [
      PricingModel(
        id: '1',
        packageName: 'Uy uchun Standart',
        description: 'Kichik uylar uchun ideal',
        price: 15000000,
        duration: '20 yil kafolat',
        includes: ['4kW tizim', 'O\'rnatish', '1 yil texnik xizmat'],
        isPopular: false,
      ),
      PricingModel(
        id: '2',
        packageName: 'Uy uchun Premium',
        description: 'O\'rta va katta uylar uchun',
        price: 25000000,
        duration: '25 yil kafolat',
        includes: [
          '8kW tizim',
          'O\'rnatish',
          '3 yil texnik xizmat',
          'Monitoring'
        ],
        isPopular: true,
      ),
      PricingModel(
        id: '3',
        packageName: 'Biznes uchun',
        description: 'Kichik biznes va ofislar uchun',
        price: 45000000,
        duration: '25 yil kafolat',
        includes: [
          '15kW tizim',
          'Professional o\'rnatish',
          '5 yil texnik xizmat',
          'Monitoring',
          '24/7 qo\'llab-quvvatlash'
        ],
        isPopular: false,
      ),
    ];

    setState(() {
      _pricingPackages = offlinePackages;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadPricing,
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
                    'Narx Paketlari',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  IconButton(
                    onPressed: _loadPricing,
                    icon: Icon(Icons.refresh, color: Colors.blue[900]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Sizning ehtiyojlaringizga mos keladigan paketni tanlang',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 30),
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pricingPackages.length,
                  itemBuilder: (context, index) {
                    return _buildPricingCard(_pricingPackages[index]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPricingCard(PricingModel package) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: package.isPopular ? Colors.blue : Colors.grey[300]!,
          width: package.isPopular ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    package.packageName,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (package.isPopular)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'Mashhur',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              package.description,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${(package.price / 1000000).toStringAsFixed(1)}M',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                const SizedBox(width: 4),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'so\'m',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              package.duration,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 16),
            Text(
              'Paketga kiradi:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 12),
            ...package.includes
                .map((item) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ))
                .toList(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  _showOrderDialog(package);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      package.isPopular ? Colors.blue : Colors.grey[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Buyurtma berish',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOrderDialog(PricingModel package) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Buyurtma berish'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Paket: ${package.packageName}'),
              Text(
                  'Narx: ${(package.price / 1000000).toStringAsFixed(1)}M so\'m'),
              const SizedBox(height: 16),
              const Text('Buyurtma berish uchun biz bilan bog\'laning:'),
              const SizedBox(height: 8),
              const Text('📞 +998 90 123 45 67'),
              const Text('📧 info@solarpanel.uz'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Yopish'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Bog\'lanish'),
            ),
          ],
        );
      },
    );
  }
}
