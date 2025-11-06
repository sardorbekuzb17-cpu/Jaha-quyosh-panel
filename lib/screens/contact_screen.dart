import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/panel_model.dart';
import '../services/api_service.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final ApiService _apiService = ApiService();
  ContactModel? _contactInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadContactInfo();
  }

  Future<void> _loadContactInfo() async {
    setState(() => _isLoading = true);

    try {
      final contactData = await _apiService.getContactInfo();
      final contact = ContactModel.fromJson(contactData);

      setState(() {
        _contactInfo = contact;
        _isLoading = false;
      });
    } catch (e) {
      // Offline ma'lumotlar
      _loadOfflineContactInfo();
    }
  }

  void _loadOfflineContactInfo() {
    final offlineContact = ContactModel(
      phone: '+998930874758',
      email: '@jahonbas',
      address: 'Navoiy viloyati, Uchquduq tumani',
      workingHours:
          'Dushanba - Juma: 9:00 - 18:00\nShanba: 10:00 - 16:00\nYakshanba: Dam olish kuni',
      socialMedia: {
        'telegram': '@jahonbas',
        'whatsapp': '+998930874758',
        'instagram': '@jahongir_solar_panels',
      },
    );

    setState(() {
      _contactInfo = offlineContact;
      _isLoading = false;
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _openSocialMedia(String platform, String username) async {
    String url = '';
    if (platform == 'telegram') {
      // @ belgisini olib tashlash
      final cleanUsername = username.replaceAll('@', '');
      url = 'https://t.me/$cleanUsername';
    } else if (platform == 'whatsapp') {
      // WhatsApp uchun telefon raqami
      final cleanPhone = username.replaceAll('+', '').replaceAll(' ', '');
      url = 'https://wa.me/$cleanPhone';
    } else if (platform == 'instagram') {
      final cleanUsername = username.replaceAll('@', '');
      url = 'https://instagram.com/$cleanUsername';
    }

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Widget _buildQuickContactButtons() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[900]!, Colors.blue[700]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            spreadRadius: 2,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Tezkor bog\'lanish',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildQuickButton(
                  icon: Icons.phone,
                  label: 'Qo\'ng\'iroq',
                  onTap: () => _makePhoneCall(_contactInfo!.phone),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickButton(
                  icon: Icons.telegram,
                  label: 'Telegram',
                  onTap: () => _openSocialMedia(
                      'telegram', _contactInfo!.socialMedia['telegram'] ?? ''),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickButton(
                  icon: Icons.chat,
                  label: 'WhatsApp',
                  onTap: () => _openSocialMedia(
                      'whatsapp', _contactInfo!.socialMedia['whatsapp'] ?? ''),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getSocialMediaIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'telegram':
        return Icons.telegram;
      case 'whatsapp':
        return Icons.chat;
      case 'instagram':
        return Icons.camera_alt;
      default:
        return Icons.link;
    }
  }

  Color _getSocialMediaColor(String platform) {
    switch (platform.toLowerCase()) {
      case 'telegram':
        return const Color(0xFF0088CC);
      case 'whatsapp':
        return const Color(0xFF25D366);
      case 'instagram':
        return const Color(0xFFE4405F);
      default:
        return Colors.blue;
    }
  }

  String _getSocialMediaName(String platform) {
    switch (platform.toLowerCase()) {
      case 'telegram':
        return 'Telegram';
      case 'whatsapp':
        return 'WhatsApp';
      case 'instagram':
        return 'Instagram';
      default:
        return platform;
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadContactInfo,
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
                    'Biz bilan bog\'lanish',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  IconButton(
                    onPressed: _loadContactInfo,
                    icon: Icon(Icons.refresh, color: Colors.blue[900]),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                'Quyosh paneli yechimlari bo\'yicha barcha savollaringizga javob oling',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[700],
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
              else if (_contactInfo != null) ...[
                // Tezkor bog'lanish tugmalari
                _buildQuickContactButtons(),

                const SizedBox(height: 30),

                // Telefon raqami
                _buildContactCard(
                  icon: Icons.phone,
                  title: 'Telefon raqami',
                  content: '+998 93 087 47 58',
                  onTap: () => _makePhoneCall(_contactInfo!.phone),
                  buttonText: 'Qo\'ng\'iroq qilish',
                ),

                const SizedBox(height: 20),

                // Telegram
                _buildContactCard(
                  icon: Icons.telegram,
                  title: 'Telegram',
                  content: _contactInfo!
                      .email, // Bu yerda email o'rniga telegram username saqlanadi
                  onTap: () =>
                      _openSocialMedia('telegram', _contactInfo!.email),
                  buttonText: 'Telegram ochish',
                ),

                const SizedBox(height: 20),

                // Manzil
                _buildInfoCard(
                  icon: Icons.location_on,
                  title: 'Manzil',
                  content: _contactInfo!.address,
                ),

                const SizedBox(height: 20),

                // Ish vaqti
                _buildInfoCard(
                  icon: Icons.access_time,
                  title: 'Ish vaqti',
                  content: _contactInfo!.workingHours,
                ),

                const SizedBox(height: 20),

                // Ijtimoiy tarmoqlar
                if (_contactInfo!.socialMedia.isNotEmpty)
                  Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.blue[900],
                                size: 30,
                              ),
                              const SizedBox(width: 15),
                              const Text(
                                'Ijtimoiy tarmoqlar',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          ..._contactInfo!.socialMedia.entries
                              .map(
                                (entry) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: InkWell(
                                    onTap: () => _openSocialMedia(
                                        entry.key, entry.value),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: _getSocialMediaColor(entry.key)
                                            .withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: _getSocialMediaColor(entry.key)
                                              .withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: _getSocialMediaColor(
                                                  entry.key),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              _getSocialMediaIcon(entry.key),
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _getSocialMediaName(
                                                      entry.key),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 2),
                                                Text(
                                                  entry.value,
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 16,
                                            color: Colors.grey[400],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 20),

                // Xizmatlar
                _buildInfoCard(
                  icon: Icons.build,
                  title: 'Xizmatlar',
                  content:
                      '• Quyosh paneli sotib olish\n• O\'rnatish xizmatlari\n• Texnik xizmat ko\'rsatish\n• Konsultatsiya\n• Loyiha ishlab chiqish\n• 24/7 qo\'llab-quvvatlash',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required String content,
    required VoidCallback onTap,
    required String buttonText,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue[900],
                  size: 30,
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      content,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[900],
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                    child: Text(
                      buttonText,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.blue[900],
                  size: 30,
                ),
                const SizedBox(width: 15),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              content,
              style: const TextStyle(
                fontSize: 16,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
