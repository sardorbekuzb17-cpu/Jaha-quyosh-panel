import 'package:flutter/material.dart';
import '../models/inverter_model.dart';
import '../widgets/inverter_card.dart';
import '../services/data_service.dart';

class InvertersScreen extends StatefulWidget {
  const InvertersScreen({Key? key}) : super(key: key);

  @override
  _InvertersScreenState createState() => _InvertersScreenState();
}

class _InvertersScreenState extends State<InvertersScreen> {
  List<Inverter> _inverters = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInverters();
  }

  void _loadInverters() async {
    setState(() => _isLoading = true);

    try {
      final invertersData = await DataService.getInverters();
      final inverters = invertersData.map((data) => Inverter(
        id: data['id'],
        name: data['name'],
        brand: data['brand'] ?? 'Unknown',
        description: data['description'],
        price: data['price'].toDouble(),
        power: data['power'].toDouble(),
        efficiency: data['efficiency'] ?? '95%',
        warranty: data['warranty'] ?? '5 yil',
        type: data['type'] ?? 'Inverter',
        features: List<String>.from(data['features'] ?? []),
        imageUrl: data['imageUrl'] ?? '',
      )).toList();
      
      setState(() {
        _inverters = inverters;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => _loadInverters(),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Inverterlar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 213, 10, 112),
                    ),
                  ),
                  IconButton(
                    onPressed: _loadInverters,
                    icon: const Icon(Icons.refresh,
                        color: Color.fromARGB(255, 213, 10, 112)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Quyosh paneli tizimi uchun yuqori sifatli inverterlar',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),

              // Content
              if (_isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(50.0),
                    child: CircularProgressIndicator(),
                  ),
                )
              else if (_inverters.isEmpty)
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.electrical_services_outlined,
                        size: 64,
                        color: Colors.orange[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Inverter topilmadi',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Hozircha inverterlar mavjud emas',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                )
              else
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _inverters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InverterCard(inverter: _inverters[index]),
                    );
                  },
                ),

              // Info section
              const SizedBox(height: 30),
              _buildInfoSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.orange[900],
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Text(
                  'Inverter haqida ma\'lumot',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Inverter - quyosh panellaridan kelayotgan to\'g\'ridan-to\'g\'ri tok (DC) ni o\'zgaruvchan tok (AC) ga aylantiruvchi qurilma. Bu sizning uyingiz va elektr tarmog\'i uchun zarur.',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Inverter afzalliklari:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Yuqori samaradorlik va ishonchlilik\n'
              '• Uzoq muddatli kafolat\n'
              '• Oson o\'rnatish va texnik xizmat ko\'rsatish',
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
