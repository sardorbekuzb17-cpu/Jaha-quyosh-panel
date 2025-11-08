import 'package:flutter/material.dart';

class AdminInvertersScreen extends StatefulWidget {
  const AdminInvertersScreen({Key? key}) : super(key: key);

  @override
  _AdminInvertersScreenState createState() => _AdminInvertersScreenState();
}

class _AdminInvertersScreenState extends State<AdminInvertersScreen> {
  List<Map<String, dynamic>> inverters = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInverters();
  }

  Future<void> _loadInverters() async {
    // Demo ma'lumotlar
    inverters = [
      {
        'id': '1',
        'name': 'GoodWe 25kW Inverter',
        'description': 'Yuqori sifatli 3-fazali inverter',
        'power': 25000,
        'efficiency': 98.5,
        'price': 25000000,
      },
      {
        'id': '2',
        'name': 'Sungrow 30kW Inverter',
        'description': 'Professional darajadagi inverter',
        'power': 30000,
        'efficiency': 98.8,
        'price': 30000000,
      },
    ];
    
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inverterlar Boshqaruvi'),
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _addInverter,
            icon: const Icon(Icons.add),
            tooltip: 'Yangi inverter qo\'shish',
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
                itemCount: inverters.length,
                itemBuilder: (context, index) {
                  final inverter = inverters[index];
                  return _buildInverterCard(inverter, index);
                },
              ),
      ),
    );
  }

  Widget _buildInverterCard(Map<String, dynamic> inverter, int index) {
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
                color: Colors.green[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.electrical_services,
                size: 40,
                color: Colors.green,
              ),
            ),
            
            const SizedBox(width: 16),
            
            // Ma'lumotlar
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inverter['name'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${inverter['power']}W - ${inverter['efficiency']}%',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(inverter['price'] / 1000000).toStringAsFixed(1)} mln so\'m',
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
                  onPressed: () => _editInverter(index),
                  icon: const Icon(Icons.edit),
                  color: Colors.blue,
                  tooltip: 'Tahrirlash',
                ),
                IconButton(
                  onPressed: () => _deleteInverter(index),
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

  void _addInverter() {
    _showInverterDialog();
  }

  void _editInverter(int index) {
    _showInverterDialog(inverter: inverters[index], index: index);
  }

  void _deleteInverter(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('O\'chirish'),
        content: const Text('Bu inverterni o\'chirishni xohlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                inverters.removeAt(index);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Inverter o\'chirildi')),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('O\'chirish'),
          ),
        ],
      ),
    );
  }

  void _showInverterDialog({Map<String, dynamic>? inverter, int? index}) {
    final nameController = TextEditingController(text: inverter?['name'] ?? '');
    final descController = TextEditingController(text: inverter?['description'] ?? '');
    final powerController = TextEditingController(text: inverter?['power']?.toString() ?? '');
    final efficiencyController = TextEditingController(text: inverter?['efficiency']?.toString() ?? '');
    final priceController = TextEditingController(text: inverter?['price']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(inverter == null ? 'Yangi Inverter' : 'Inverter Tahrirlash'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Inverter nomi'),
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
            onPressed: () {
              final newInverter = {
                'id': inverter?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                'name': nameController.text,
                'description': descController.text,
                'power': int.tryParse(powerController.text) ?? 0,
                'efficiency': double.tryParse(efficiencyController.text) ?? 0.0,
                'price': int.tryParse(priceController.text) ?? 0,
              };

              setState(() {
                if (index != null) {
                  inverters[index] = newInverter;
                } else {
                  inverters.add(newInverter);
                }
              });

              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(inverter == null ? 'Inverter qo\'shildi' : 'Inverter yangilandi')),
              );
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }
}