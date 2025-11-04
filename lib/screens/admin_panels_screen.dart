import 'package:flutter/material.dart';
import '../models/panel_model.dart';

class AdminPanelsScreen extends StatefulWidget {
  const AdminPanelsScreen({Key? key}) : super(key: key);

  @override
  _AdminPanelsScreenState createState() => _AdminPanelsScreenState();
}

class _AdminPanelsScreenState extends State<AdminPanelsScreen> {
  List<PanelModel> _panels = [];

  @override
  void initState() {
    super.initState();
    _loadPanels();
  }

  void _loadPanels() {
    // Demo ma'lumotlar
    _panels = [
      PanelModel(
        id: '1',
        name: 'Monokristalin Panel 400W',
        description: 'Yuqori samaradorlik va uzoq muddatli ishonchlilik',
        imageUrl: 'assets/images/mono_panel.jpg',
        power: 400.0,
        efficiency: 22.0,
        warranty: '25 yil',
        price: 150.0,
        features: ['Yuqori samaradorlik', 'Kam joy egallaydi', 'Uzoq muddatli'],
      ),
      PanelModel(
        id: '2',
        name: 'Polikristalin Panel 350W',
        description: 'Arzon narx va yaxshi sifat',
        imageUrl: 'assets/images/poly_panel.jpg',
        power: 350.0,
        efficiency: 18.0,
        warranty: '20 yil',
        price: 120.0,
        features: ['Arzon narx', 'Yaxshi sifat', 'Oson o\'rnatish'],
      ),
    ];
    setState(() {});
  }

  void _addPanel() {
    _showPanelDialog();
  }

  void _editPanel(PanelModel panel) {
    _showPanelDialog(panel: panel);
  }

  void _deletePanel(String panelId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Panel o\'chirish'),
        content: const Text('Haqiqatan ham bu panelni o\'chirmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _panels.removeWhere((p) => p.id == panelId);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Panel o\'chirildi')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('O\'chirish', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showPanelDialog({PanelModel? panel}) {
    final isEditing = panel != null;
    final nameController = TextEditingController(text: panel?.name ?? '');
    final descriptionController =
        TextEditingController(text: panel?.description ?? '');
    final powerController =
        TextEditingController(text: panel?.power.toString() ?? '');
    final efficiencyController =
        TextEditingController(text: panel?.efficiency.toString() ?? '');
    final warrantyController =
        TextEditingController(text: panel?.warranty ?? '');
    final priceController =
        TextEditingController(text: panel?.price.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEditing ? 'Panel tahrirlash' : 'Yangi panel qo\'shish'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Panel nomi',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Tavsif',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: powerController,
                      decoration: const InputDecoration(
                        labelText: 'Quvvat (W)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: efficiencyController,
                      decoration: const InputDecoration(
                        labelText: 'Samaradorlik (%)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: warrantyController,
                      decoration: const InputDecoration(
                        labelText: 'Kafolat',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: priceController,
                      decoration: const InputDecoration(
                        labelText: 'Narx (\$)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () {
              final newPanel = PanelModel(
                id: panel?.id ??
                    DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text,
                description: descriptionController.text,
                imageUrl: panel?.imageUrl ?? 'assets/images/default_panel.jpg',
                power: double.tryParse(powerController.text) ?? 0,
                efficiency: double.tryParse(efficiencyController.text) ?? 0,
                warranty: warrantyController.text,
                price: double.tryParse(priceController.text) ?? 0,
                features: panel?.features ?? ['Yangi panel'],
              );

              setState(() {
                if (isEditing) {
                  final index = _panels.indexWhere((p) => p.id == panel!.id);
                  if (index != -1) {
                    _panels[index] = newPanel;
                  }
                } else {
                  _panels.add(newPanel);
                }
              });

              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(isEditing
                      ? 'Panel yangilandi'
                      : 'Yangi panel qo\'shildi'),
                ),
              );
            },
            child: Text(isEditing ? 'Yangilash' : 'Qo\'shish'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel turlari'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _addPanel,
            icon: const Icon(Icons.add),
            tooltip: 'Yangi panel qo\'shish',
          ),
        ],
      ),
      body: _panels.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.solar_power, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Hech qanday panel yo\'q',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _panels.length,
              itemBuilder: (context, index) {
                final panel = _panels[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
                              child: Icon(
                                Icons.solar_power,
                                color: Colors.blue[900],
                                size: 30,
                              ),
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
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'edit') {
                                  _editPanel(panel);
                                } else if (value == 'delete') {
                                  _deletePanel(panel.id);
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(
                                  value: 'edit',
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit, size: 16),
                                      SizedBox(width: 8),
                                      Text('Tahrirlash'),
                                    ],
                                  ),
                                ),
                                const PopupMenuItem(
                                  value: 'delete',
                                  child: Row(
                                    children: [
                                      Icon(Icons.delete,
                                          size: 16, color: Colors.red),
                                      SizedBox(width: 8),
                                      Text('O\'chirish',
                                          style: TextStyle(color: Colors.red)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildInfoChip(
                                '${panel.power.toInt()}W', Icons.flash_on),
                            const SizedBox(width: 8),
                            _buildInfoChip(
                                '${panel.efficiency}%', Icons.trending_up),
                            const SizedBox(width: 8),
                            _buildInfoChip(panel.warranty, Icons.verified_user),
                          ],
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
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () => _editPanel(panel),
                                  child: const Text('Tahrirlash'),
                                ),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () => _deletePanel(panel.id),
                                  style: TextButton.styleFrom(
                                    foregroundColor: Colors.red,
                                  ),
                                  child: const Text('O\'chirish'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPanel,
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add, color: Colors.white),
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
