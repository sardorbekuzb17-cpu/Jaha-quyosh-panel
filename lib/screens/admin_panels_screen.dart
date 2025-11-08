import 'package:flutter/material.dart';
import '../services/data_service.dart';

class AdminPanelsScreen extends StatefulWidget {
  const AdminPanelsScreen({Key? key}) : super(key: key);

  @override
  _AdminPanelsScreenState createState() => _AdminPanelsScreenState();
}

class _AdminPanelsScreenState extends State<AdminPanelsScreen> {
  List<Map<String, dynamic>> panels = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPanels();
  }

  Future<void> _loadPanels() async {
    final loadedPanels = await DataService.getPanels();
    setState(() {
      panels = loadedPanels;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panellar Boshqaruvi'),
        backgroundColor: Colors.orange[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _addPanel,
            icon: const Icon(Icons.add),
            tooltip: 'Yangi panel qo\'shish',
          ),
        ],
      ),
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
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: panels.length,
                itemBuilder: (context, index) {
                  final panel = panels[index];
                  return _buildPanelCard(panel, index);
                },
              ),
      ),
    );
  }

  Widget _buildPanelCard(Map<String, dynamic> panel, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Rasm
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.orange[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.solar_power,
                size: 40,
                color: Colors.orange,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Ma'lumotlar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    panel['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${panel['power']}W - ${panel['efficiency']}%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(panel['price'] / 1000000).toStringAsFixed(1)} mln so\'m',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ),
            
            // Tugmalar
            Column(
              children: [
                IconButton(
                  onPressed: () => _editPanel(index),
                  icon: const Icon(Icons.edit),
                  color: Colors.blue,
                  tooltip: 'Tahrirlash',
                ),
                IconButton(
                  onPressed: () => _deletePanel(index),
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                  tooltip: 'O\'chirish',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addPanel() {
    _showPanelDialog();
  }

  void _editPanel(int index) {
    _showPanelDialog(panel: panels[index], index: index);
  }

  void _deletePanel(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('O\'chirish'),
        content: const Text('Bu panelni o\'chirishni xohlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                panels.removeAt(index);
              });
              
              // Ma'lumotlarni saqlash
              await DataService.savePanels(panels);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Panel o\'chirildi')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('O\'chirish'),
          ),
        ],
      ),
    );
  }

  void _showPanelDialog({Map<String, dynamic>? panel, int? index}) {
    final nameController = TextEditingController(text: panel?['name'] ?? '');
    final descController = TextEditingController(text: panel?['description'] ?? '');
    final powerController = TextEditingController(text: panel?['power']?.toString() ?? '');
    final efficiencyController = TextEditingController(text: panel?['efficiency']?.toString() ?? '');
    final priceController = TextEditingController(text: panel?['price']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(panel == null ? 'Yangi Panel' : 'Panel Tahrirlash'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Panel nomi'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Tavsif'),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: powerController,
                decoration: const InputDecoration(labelText: 'Quvvat (W)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: efficiencyController,
                decoration: const InputDecoration(labelText: 'Samaradorlik (%)'),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Narx (so\'m)'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newPanel = {
                'id': panel?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                'name': nameController.text,
                'description': descController.text,
                'image_url': 'assets/images/panels/photo_2025-11-07_21-55-24.jpg',
                'power': int.tryParse(powerController.text) ?? 0,
                'efficiency': double.tryParse(efficiencyController.text) ?? 0.0,
                'warranty': '25 yil',
                'price': int.tryParse(priceController.text) ?? 0,
              };

              setState(() {
                if (index != null) {
                  panels[index] = newPanel;
                } else {
                  panels.add(newPanel);
                }
              });
              
              // Ma'lumotlarni saqlash
              await DataService.savePanels(panels);

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(panel == null ? 'Panel qo\'shildi' : 'Panel yangilandi')),
              );
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }
}