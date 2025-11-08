import 'package:flutter/material.dart';
import '../services/data_service.dart';

class AdminModullarScreen extends StatefulWidget {
  const AdminModullarScreen({Key? key}) : super(key: key);

  @override
  _AdminModullarScreenState createState() => _AdminModullarScreenState();
}

class _AdminModullarScreenState extends State<AdminModullarScreen> {
  List<Map<String, dynamic>> modullar = [];

  @override
  void initState() {
    super.initState();
    _loadModullar();
  }

  void _loadModullar() async {
    final loadedModules = await DataService.getModules();
    setState(() {
      modullar = loadedModules;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modullar Boshqaruvi'),
        backgroundColor: Colors.purple[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _addModul,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Colors.white],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: modullar.length,
          itemBuilder: (context, index) => _buildModulCard(modullar[index], index),
        ),
      ),
    );
  }

  Widget _buildModulCard(Map<String, dynamic> modul, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.purple[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.view_module, color: Colors.purple),
        ),
        title: Text(modul['name']),
        subtitle: Text('${modul['power']}W - ${modul['efficiency']}%'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () => _editModul(index),
              icon: const Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: () => _deleteModul(index),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _addModul() => _showModulDialog();
  void _editModul(int index) => _showModulDialog(modul: modullar[index], index: index);

  void _deleteModul(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('O\'chirish'),
        content: const Text('Bu modulni o\'chirishni xohlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yo\'q'),
          ),
          ElevatedButton(
            onPressed: () async {
              setState(() => modullar.removeAt(index));
              await DataService.saveModules(modullar);
              Navigator.pop(context);
            },
            child: const Text('Ha'),
          ),
        ],
      ),
    );
  }

  void _showModulDialog({Map<String, dynamic>? modul, int? index}) {
    final nameController = TextEditingController(text: modul?['name'] ?? '');
    final descController = TextEditingController(text: modul?['description'] ?? '');
    final powerController = TextEditingController(text: modul?['power']?.toString() ?? '');
    final efficiencyController = TextEditingController(text: modul?['efficiency']?.toString() ?? '');
    final priceController = TextEditingController(text: modul?['price']?.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(modul == null ? 'Yangi Modul' : 'Modul Tahrirlash'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Nomi')),
              TextField(controller: descController, decoration: const InputDecoration(labelText: 'Tavsif')),
              TextField(controller: powerController, decoration: const InputDecoration(labelText: 'Quvvat (W)'), keyboardType: TextInputType.number),
              TextField(controller: efficiencyController, decoration: const InputDecoration(labelText: 'Samaradorlik (%)'), keyboardType: TextInputType.number),
              TextField(controller: priceController, decoration: const InputDecoration(labelText: 'Narx'), keyboardType: TextInputType.number),
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Bekor qilish')),
          ElevatedButton(
            onPressed: () async {
              final newModul = {
                'id': modul?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                'name': nameController.text,
                'description': descController.text,
                'power': int.tryParse(powerController.text) ?? 0,
                'efficiency': double.tryParse(efficiencyController.text) ?? 0.0,
                'price': int.tryParse(priceController.text) ?? 0,
              };
              setState(() {
                if (index != null) {
                  modullar[index] = newModul;
                } else {
                  modullar.add(newModul);
                }
              });
              await DataService.saveModules(modullar);
              Navigator.pop(context);
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }
}