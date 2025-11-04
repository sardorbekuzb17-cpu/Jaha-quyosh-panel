import 'package:flutter/material.dart';
import '../models/panel_model.dart';
import '../services/api_service.dart';
import '../widgets/panel_card.dart';

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
    setState(() => _isLoading = true);

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
                  child: Row(
                    children: [
                      const Icon(Icons.warning, color: Colors.orange),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Offline rejim',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
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
