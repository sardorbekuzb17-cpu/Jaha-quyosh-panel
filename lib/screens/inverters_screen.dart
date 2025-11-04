import 'package:flutter/material.dart';
import '../models/inverter_model.dart';
import '../widgets/inverter_card.dart';

class InvertersScreen extends StatefulWidget {
  const InvertersScreen({Key? key}) : super(key: key);

  @override
  _InvertersScreenState createState() => _InvertersScreenState();
}

class _InvertersScreenState extends State<InvertersScreen> {
  List<Inverter> _inverters = [];
  List<Inverter> _filteredInverters = [];
  bool _isLoading = true;
  String _selectedType = 'Barchasi';
  String _searchQuery = '';

  final List<String> _inverterTypes = [
    'Barchasi',
    'String Inverter',
    'Hybrid Inverter',
  ];

  @override
  void initState() {
    super.initState();
    _loadInverters();
  }

  void _loadInverters() {
    setState(() => _isLoading = true);

    // Simulate loading delay
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _inverters = InverterData.getInverters();
        _filteredInverters = _inverters;
        _isLoading = false;
      });
    });
  }

  void _filterInverters() {
    setState(() {
      _filteredInverters = _inverters.where((inverter) {
        final matchesType =
            _selectedType == 'Barchasi' || inverter.type == _selectedType;
        final matchesSearch = inverter.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            inverter.brand.toLowerCase().contains(_searchQuery.toLowerCase());
        return matchesType && matchesSearch;
      }).toList();
    });
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
                  Text(
                    'Inverterlar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[900],
                    ),
                  ),
                  IconButton(
                    onPressed: _loadInverters,
                    icon: Icon(Icons.refresh, color: Colors.orange[900]),
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

              // Search bar
              TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                  _filterInverters();
                },
                decoration: InputDecoration(
                  hintText: 'Inverter qidirish...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 20),

              // Filter chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _inverterTypes.map((type) {
                    final isSelected = _selectedType == type;
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: FilterChip(
                        label: Text(type),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            _selectedType = type;
                          });
                          _filterInverters();
                        },
                        backgroundColor: Colors.grey[200],
                        selectedColor: Colors.orange[100],
                        checkmarkColor: Colors.orange[900],
                      ),
                    );
                  }).toList(),
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
              else if (_filteredInverters.isEmpty)
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
                        'Qidiruv shartlaringizni o\'zgartiring yoki boshqa kategoriyani tanlang',
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
                  itemCount: _filteredInverters.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: InverterCard(inverter: _filteredInverters[index]),
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
              'Inverter turlari:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• String Inverter - Bir nechta panelni ketma-ket ulash\n'
              '• Hybrid Inverter - Batareya bilan ishlash imkoniyati\n'
              '• Micro Inverter - Har bir panel uchun alohida',
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
