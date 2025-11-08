import 'package:flutter/material.dart';
import '../services/data_service.dart';

class AdminContactScreen extends StatefulWidget {
  const AdminContactScreen({Key? key}) : super(key: key);

  @override
  _AdminContactScreenState createState() => _AdminContactScreenState();
}

class _AdminContactScreenState extends State<AdminContactScreen> {
  final _phoneController = TextEditingController();
  final _telegramController = TextEditingController();
  final _instagramController = TextEditingController();
  final _addressController = TextEditingController();
  final _emailController = TextEditingController();
  final _websiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadContactInfo();
  }

  void _loadContactInfo() async {
    final contact = await DataService.getContact();
    _phoneController.text = contact['phone'] ?? '';
    _telegramController.text = contact['telegram'] ?? '';
    _instagramController.text = contact['instagram'] ?? '';
    _addressController.text = contact['address'] ?? '';
    _emailController.text = contact['email'] ?? '';
    _websiteController.text = contact['website'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aloqa Ma\'lumotlari'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _saveContact,
            icon: const Icon(Icons.save),
            tooltip: 'Saqlash',
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFF8FAFC), Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildContactCard(
                'Telefon',
                Icons.phone,
                Colors.green,
                _phoneController,
                'Telefon raqamini kiriting',
              ),
              
              _buildContactCard(
                'Telegram',
                Icons.telegram,
                Colors.blue,
                _telegramController,
                'Telegram username kiriting',
              ),
              
              _buildContactCard(
                'Instagram',
                Icons.camera_alt,
                Colors.purple,
                _instagramController,
                'Instagram username kiriting',
              ),
              
              _buildContactCard(
                'Email',
                Icons.email,
                Colors.red,
                _emailController,
                'Email manzilini kiriting',
              ),
              
              _buildContactCard(
                'Website',
                Icons.web,
                Colors.orange,
                _websiteController,
                'Website manzilini kiriting',
              ),
              
              _buildContactCard(
                'Manzil',
                Icons.location_on,
                Colors.teal,
                _addressController,
                'To\'liq manzilni kiriting',
                maxLines: 3,
              ),
              
              const SizedBox(height: 20),
              
              // Saqlash tugmasi
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _saveContact,
                  icon: const Icon(Icons.save),
                  label: const Text('Barcha Ma\'lumotlarni Saqlash'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    String title,
    IconData icon,
    Color color,
    TextEditingController controller,
    String hint, {
    int maxLines = 1,
  }) {
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hint,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: color, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveContact() async {
    final contactData = {
      'phone': _phoneController.text,
      'telegram': _telegramController.text,
      'instagram': _instagramController.text,
      'address': _addressController.text,
      'email': _emailController.text,
      'website': _websiteController.text,
      'services': 'Quyosh paneli o\'rnatish, texnik xizmat ko\'rsatish, konsultatsiya',
    };
    
    await DataService.saveContact(contactData);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Muvaffaqiyat'),
        content: const Text('Aloqa ma\'lumotlari saqlandi!'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _telegramController.dispose();
    _instagramController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    _websiteController.dispose();
    super.dispose();
  }
}