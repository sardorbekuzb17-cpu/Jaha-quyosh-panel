import 'package:flutter/material.dart';

class AdminAdsScreen extends StatefulWidget {
  const AdminAdsScreen({Key? key}) : super(key: key);

  @override
  _AdminAdsScreenState createState() => _AdminAdsScreenState();
}

class _AdminAdsScreenState extends State<AdminAdsScreen> {
  List<Map<String, dynamic>> ads = [];

  @override
  void initState() {
    super.initState();
    _loadAds();
  }

  void _loadAds() {
    ads = [
      {
        'id': '1',
        'title': 'LONGi Solar Panellari',
        'subtitle': 'Jahon yetakchi brendi',
        'image': 'assets/images/ads/1.jpg',
        'active': true,
      },
      {
        'id': '2',
        'title': 'Premium Panellar',
        'subtitle': 'Eng yaxshi sifat',
        'image': 'assets/images/ads/2.jpg',
        'active': true,
      },
    ];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reklamalar Boshqaruvi'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: _addAd,
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
          itemCount: ads.length,
          itemBuilder: (context, index) => _buildAdCard(ads[index], index),
        ),
      ),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad, int index) {
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
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.campaign, color: Colors.red),
        ),
        title: Text(ad['title']),
        subtitle: Text(ad['subtitle']),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Switch(
              value: ad['active'],
              onChanged: (value) {
                setState(() {
                  ads[index]['active'] = value;
                });
              },
            ),
            IconButton(
              onPressed: () => _editAd(index),
              icon: const Icon(Icons.edit, color: Colors.blue),
            ),
            IconButton(
              onPressed: () => _deleteAd(index),
              icon: const Icon(Icons.delete, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void _addAd() => _showAdDialog();
  void _editAd(int index) => _showAdDialog(ad: ads[index], index: index);

  void _deleteAd(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('O\'chirish'),
        content: const Text('Bu reklamani o\'chirishni xohlaysizmi?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Yo\'q'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => ads.removeAt(index));
              Navigator.pop(context);
            },
            child: const Text('Ha'),
          ),
        ],
      ),
    );
  }

  void _showAdDialog({Map<String, dynamic>? ad, int? index}) {
    final titleController = TextEditingController(text: ad?['title'] ?? '');
    final subtitleController = TextEditingController(text: ad?['subtitle'] ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(ad == null ? 'Yangi Reklama' : 'Reklama Tahrirlash'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Sarlavha')),
            TextField(controller: subtitleController, decoration: const InputDecoration(labelText: 'Qo\'shimcha matn')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Bekor qilish')),
          ElevatedButton(
            onPressed: () {
              final newAd = {
                'id': ad?['id'] ?? DateTime.now().millisecondsSinceEpoch.toString(),
                'title': titleController.text,
                'subtitle': subtitleController.text,
                'image': 'assets/images/ads/1.jpg',
                'active': ad?['active'] ?? true,
              };
              setState(() {
                if (index != null) {
                  ads[index] = newAd;
                } else {
                  ads.add(newAd);
                }
              });
              Navigator.pop(context);
            },
            child: const Text('Saqlash'),
          ),
        ],
      ),
    );
  }
}