import 'package:flutter/material.dart';
import 'dart:convert';
import '../models/panel_model.dart';
import '../widgets/panel_card.dart';
import '../services/data_service.dart';

class PanelsScreen extends StatefulWidget {
  const PanelsScreen({Key? key}) : super(key: key);

  @override
  _PanelsScreenState createState() => _PanelsScreenState();
}

class _PanelsScreenState extends State<PanelsScreen> {
  List<PanelModel> _panels = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPanels();
  }

  Future<void> _loadPanels() async {
    setState(() => _isLoading = true);

    try {
      // DataService'dan ma'lumotlarni yuklash
      final panelsData = await DataService.getPanels();
      final panels = panelsData.map((data) => PanelModel(
        id: data['id'],
        name: data['name'],
        description: data['description'],
        imageUrl: data['image_url'] ?? '',
        power: data['power'],
        efficiency: data['efficiency'].toDouble(),
        warranty: data['warranty'],
        price: data['price'],
        features: ['Yuqori sifat', 'Ishonchli', 'Samarali'],
      )).toList();
      
      setState(() {
        _panels = panels;
        _isLoading = false;
        _errorMessage = '';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Ma\'lumotlarni yuklashda xatolik: $e';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadLocalPanels() async {
    try {
      // JSON fayldan o'qish
      final String response =
          await DefaultAssetBundle.of(context).loadString('public/panels.json');

      final data = json.decode(response);
      final List<dynamic> panelsJson = data['panels'];

      final panels =
          panelsJson.map((data) => PanelModel.fromJson(data)).toList();

      setState(() {
        _panels = panels;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('JSON fayldan o\'qishda xato: $e');
      // Xato bo'lsa, offline ma'lumotlarni yuklash
      _loadOfflineData();
    }
  }

  void _loadOfflineData() {
    // Real panellar ma'lumotlari
    final solarPanels = SolarPanelData.getPanels();
    final offlinePanels = solarPanels
        .map((panel) => PanelModel(
              id: panel.id,
              name: panel.name,
              description: panel.description,
              imageUrl: '',
              power: panel.power,
              efficiency: double.parse(panel.efficiency.replaceAll('%', '')),
              warranty: panel.warranty,
              price: panel.price,
              features: ['Yuqori sifat', 'Ishonchli', 'Samarali'],
            ))
        .toList();

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
                    'Panel turlari',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue.shade900,
                    ),
                  ),
                  IconButton(
                    onPressed: _loadPanels,
                    icon: Icon(Icons.refresh, color: Colors.blue.shade900),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Turli xil quyosh panellari va ularning xususiyatlari',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade700,
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
              else if (_errorMessage.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade50,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange.shade200),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Offline rejim',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Internet aloqasi yo\'q. Offline ma\'lumotlar ko\'rsatilmoqda.',
                            ),
                          ],
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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: PanelCard(panel: _panels[index]),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
