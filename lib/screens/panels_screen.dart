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

  @override
  void initState() {
    super.initState();
    _loadPanels();
  }

  Future<void> _loadPanels() async {
    setState(() => _isLoading = true);

    try {
      final panelsData = await _apiService.getPanels();

      if (panelsData.isNotEmpty) {
        final panels =
            panelsData.map((data) => PanelModel.fromJson(data)).toList();
        setState(() {
          _panels = panels;
          _isLoading = false;
        });
      } else {
        _loadOfflineData();
      }
    } catch (e) {
      _loadOfflineData();
    }
  }

  void _loadOfflineData() {
    final solarPanels = SolarPanelData.getPanels();

    final offlinePanels = solarPanels.map((panel) {
      return PanelModel(
        id: panel.id,
        name: panel.name,
        description: panel.description,
        imageUrl: panel.imageUrl,
        power: panel.power,
        efficiency: double.parse(panel.efficiency.replaceAll('%', '').trim()),
        warranty: panel.warranty,
        price: panel.price,
        features: ['Yuqori sifat', 'Ishonchli', 'Samarali'],
      );
    }).toList();

    setState(() {
      _panels = offlinePanels;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadPanels,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _panels.isEmpty
              ? const Center(
                  child: Text(
                    'Hech qanday panel topilmadi',
                    style: TextStyle(fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _panels.length + 1,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Column(
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
                                icon: Icon(Icons.refresh,
                                    color: Colors.blue.shade900),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Turli xil quyosh panellari va ularning xususiyatlari',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    }
                    return PanelCard(panel: _panels[index - 1]);
                  },
                ),
    );
  }
}
