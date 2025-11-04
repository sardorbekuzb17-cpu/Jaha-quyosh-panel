import 'package:flutter/material.dart';
import '../models/panel_model.dart';

class AdminPricingScreen extends StatefulWidget {
  const AdminPricingScreen({Key? key}) : super(key: key);

  @override
  _AdminPricingScreenState createState() => _AdminPricingScreenState();
}

class _AdminPricingScreenState extends State<AdminPricingScreen> {
  List<PricingModel> _packages = [];

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  void _loadPackages() {
    _packages = [
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
    ];
    setState(() {});
  }

  void _addPackage() {
    _showPackageDialog();
  }

  void _editPackage(PricingModel package) {
    _showPackageDialog(package: package);
  }

  void _deletePackage(String packageId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Paket o\'chirish'),
        content: const Text('Haqiqatan ham bu paketni o\'chirmoqchimisiz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _packages.removeWhere((p) => p.id == packageId);
              });
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Paket o\'chirildi')),
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

  void _showPackageDialog({PricingModel? package}) {
    final isEditing = package != null;
    final nameController =
        TextEditingController(text: package?.packageName ?? '');
    final descriptionController =
        TextEditingController(text: package?.description ?? '');
    final priceController =
        TextEditingController(text: package?.price.toString() ?? '');
    final durationController =
        TextEditingController(text: package?.duration ?? '');
    bool isPopular = package?.isPopular ?? false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(isEditing ? 'Paket tahrirlash' : 'Yangi paket qo\'shish'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Paket nomi',
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
                TextField(
                  controller: priceController,
                  decoration: const InputDecoration(
                    labelText: 'Narx (so\'m)',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: durationController,
                  decoration: const InputDecoration(
                    labelText: 'Muddat',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                CheckboxListTile(
                  title: const Text('Mashhur paket'),
                  value: isPopular,
                  onChanged: (value) {
                    setDialogState(() {
                      isPopular = value ?? false;
                    });
                  },
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
                final newPackage = PricingModel(
                  id: package?.id ??
                      DateTime.now().millisecondsSinceEpoch.toString(),
                  packageName: nameController.text,
                  description: descriptionController.text,
                  price: double.tryParse(priceController.text) ?? 0,
                  duration: durationController.text,
                  includes: package?.includes ?? ['Standart xizmatlar'],
                  isPopular: isPopular,
                );

                setState(() {
                  if (isEditing) {
                    final index =
                        _packages.indexWhere((p) => p.id == package!.id);
                    if (index != -1) {
                      _packages[index] = newPackage;
                    }
                  } else {
                    _packages.add(newPackage);
                  }
                });

                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(isEditing
                        ? 'Paket yangilandi'
                        : 'Yangi paket qo\'shildi'),
                  ),
                );
              },
              child: Text(isEditing ? 'Yangilash' : 'Qo\'shish'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Narx paketlari'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _addPackage,
            icon: const Icon(Icons.add),
            tooltip: 'Yangi paket qo\'shish',
          ),
        ],
      ),
      body: _packages.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.price_change, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Hech qanday paket yo\'q',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _packages.length,
              itemBuilder: (context, index) {
                final package = _packages[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color:
                          package.isPopular ? Colors.blue : Colors.grey[300]!,
                      width: package.isPopular ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.1),
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
                            Row(
                              children: [
                                if (package.isPopular)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
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
                                const SizedBox(width: 8),
                                PopupMenuButton<String>(
                                  onSelected: (value) {
                                    if (value == 'edit') {
                                      _editPackage(package);
                                    } else if (value == 'delete') {
                                      _deletePackage(package.id);
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
                                              style:
                                                  TextStyle(color: Colors.red)),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
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
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _editPackage(package),
                                child: const Text('Tahrirlash'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _deletePackage(package.id),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text('O\'chirish',
                                    style: TextStyle(color: Colors.white)),
                              ),
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
        onPressed: _addPackage,
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
