import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';
import '../services/notification_service.dart';

class OrderScreen extends StatefulWidget {
  final String? preSelectedPanel;
  final String? preSelectedInverter;

  const OrderScreen({
    Key? key,
    this.preSelectedPanel,
    this.preSelectedInverter,
  }) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _orderService = OrderService();
  final _notificationService = NotificationService();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _additionalInfoController = TextEditingController();

  String _selectedPanel = '';
  String? _selectedInverter;
  int _quantity = 1;
  bool _isSubmitting = false;

  final List<String> _panelTypes = [
    'Longi 550W',
    'JA Solar 545W',
    'Trina Solar 540W',
    'Canadian Solar 535W',
  ];

  final List<String> _inverterTypes = [
    'Yo\'q',
    'Huawei 5kW',
    'Growatt 10kW',
    'Solis 15kW',
  ];

  @override
  void initState() {
    super.initState();
    _selectedPanel = widget.preSelectedPanel ?? _panelTypes[0];
    _selectedInverter = _inverterTypes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buyurtma Berish'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sarlavha
              Text(
                'Buyurtma Ma\'lumotlari',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 20),

              // Ism
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Ism Familiya *',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, ismingizni kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Telefon
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'Telefon Raqam *',
                  prefixIcon: const Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: '+998 90 123 45 67',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, telefon raqamingizni kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              // Manzil
              TextFormField(
                controller: _addressController,
                maxLines: 2,
                decoration: InputDecoration(
                  labelText: 'Manzil *',
                  prefixIcon: const Icon(Icons.location_on),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Iltimos, manzilingizni kiriting';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Panel tanlash
              Text(
                'Panel Turi *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedPanel,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.solar_power),
                ),
                items: _panelTypes.map((panel) {
                  return DropdownMenuItem(
                    value: panel,
                    child: Text(panel),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedPanel = value!;
                  });
                },
              ),
              const SizedBox(height: 15),

              // Soni
              Text(
                'Soni *',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (_quantity > 1) {
                        setState(() {
                          _quantity--;
                        });
                      }
                    },
                    icon: const Icon(Icons.remove_circle),
                    color: Colors.red,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$_quantity',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _quantity++;
                      });
                    },
                    icon: const Icon(Icons.add_circle),
                    color: Colors.green,
                  ),
                ],
              ),
              const SizedBox(height: 15),

              // Inverter tanlash
              Text(
                'Inverter (ixtiyoriy)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedInverter,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: const Icon(Icons.electrical_services),
                ),
                items: _inverterTypes.map((inverter) {
                  return DropdownMenuItem(
                    value: inverter,
                    child: Text(inverter),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedInverter = value;
                  });
                },
              ),
              const SizedBox(height: 15),

              // Qo'shimcha ma'lumot
              TextFormField(
                controller: _additionalInfoController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Qo\'shimcha Ma\'lumot (ixtiyoriy)',
                  prefixIcon: const Icon(Icons.note),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Maxsus talablar yoki savollar...',
                ),
              ),
              const SizedBox(height: 25),

              // Yuborish tugmasi
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submitOrder,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[900],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Buyurtma Berish',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitOrder() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    final order = OrderModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      customerName: _nameController.text,
      phoneNumber: _phoneController.text,
      address: _addressController.text,
      panelType: _selectedPanel,
      quantity: _quantity,
      inverterType: _selectedInverter != 'Yo\'q' ? _selectedInverter : null,
      additionalInfo: _additionalInfoController.text.isNotEmpty
          ? _additionalInfoController.text
          : null,
      orderDate: DateTime.now(),
    );

    final success = await _orderService.submitOrder(order);

    setState(() {
      _isSubmitting = false;
    });

    if (success) {
      // Bildirishnoma yuborish
      await _notificationService.showNotification(
        title: '✅ Buyurtma Qabul Qilindi',
        body: 'Tez orada siz bilan bog\'lanamiz!',
      );

      // Muvaffaqiyatli dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('✅ Muvaffaqiyatli'),
          content: const Text(
            'Buyurtmangiz qabul qilindi!\nTez orada siz bilan bog\'lanamiz.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Xatolik dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('⚠️ Xatolik'),
          content: const Text(
            'Buyurtma yuborishda xatolik yuz berdi.\nBuyurtmangiz lokal saqlandi va keyinroq yuboriladi.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _additionalInfoController.dispose();
    super.dispose();
  }
}
