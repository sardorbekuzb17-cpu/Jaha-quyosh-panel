import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  static const String phoneNumber1 = '+998930874758';
  static const String phoneNumber2 = '+998942240514';
  static const String telegramLink = 'https://t.me/quyosh24_sun24';
  static const String instagramLink =
      'https://www.instagram.com/quyosh24_?igsh=MWx6bXdydjYwaG56MA==';

  late AnimationController _colorController;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _colorController.dispose();
    super.dispose();
  }

  Future<void> _makePhoneCall(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _openTelegram() async {
    final Uri telegramUri = Uri.parse(telegramLink);
    if (await canLaunchUrl(telegramUri)) {
      await launchUrl(telegramUri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _openInstagram() async {
    final Uri instagramUri = Uri.parse(instagramLink);
    if (await canLaunchUrl(instagramUri)) {
      await launchUrl(instagramUri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // Logo
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[800]!, Colors.blue[600]!],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    spreadRadius: 4,
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const Icon(Icons.support_agent,
                  size: 50, color: Colors.white),
            ),

            const SizedBox(height: 20),

            Text(
              'Biz bilan bog\'lanish',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Savollaringizga javob olish uchun bog\'laning',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),

            const SizedBox(height: 30),

            // Telefon raqamlar - 2 ta karta
            Row(
              children: [
                Expanded(
                    child: _buildPhoneCard(
                        '93 087 47 58', phoneNumber1, Colors.green)),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildPhoneCard(
                        '94 224 05 14', phoneNumber2, Colors.teal)),
              ],
            ),

            const SizedBox(height: 16),

            // Telegram va Instagram - 2 ta karta
            Row(
              children: [
                Expanded(
                    child: _buildSocialCard(
                  'Telegram',
                  '@quyosh24_sun24',
                  Icons.telegram,
                  const Color(0xFF0088CC),
                  _openTelegram,
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildSocialCard(
                  'Instagram',
                  '@quyosh24_',
                  Icons.camera_alt,
                  const Color(0xFFE4405F),
                  _openInstagram,
                )),
              ],
            ),

            const SizedBox(height: 24),

            // Manzil va Ish vaqti
            Row(
              children: [
                Expanded(
                    child: _buildInfoCard(
                  'Manzil',
                  'Navoiy viloyati\nUchquduq tumani\n13-A28',
                  Icons.location_on,
                  Colors.orange,
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: _buildInfoCard(
                  'Ish vaqti',
                  'Du-Ju: 8:00-19:00\nSha: 9:00-17:00\nYak: 10:00-15:00',
                  Icons.access_time,
                  Colors.purple,
                )),
              ],
            ),

            const SizedBox(height: 24),

            // Xizmatlar - RGB animatsiya
            AnimatedBuilder(
              animation: _colorController,
              builder: (context, child) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(Colors.blue, Colors.purple,
                            _colorController.value)!,
                        Color.lerp(Colors.purple, Colors.orange,
                            _colorController.value)!,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.build_circle,
                          size: 36, color: Colors.white),
                      const SizedBox(height: 12),
                      const Text(
                        'Bizning xizmatlar',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildServiceChip('Sotib olish'),
                          _buildServiceChip('O\'rnatish'),
                          _buildServiceChip('Texnik xizmat'),
                          _buildServiceChip('Konsultatsiya'),
                          _buildServiceChip('Loyihalash'),
                          _buildServiceChip('Kafolat'),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneCard(String displayNumber, String fullNumber, Color color) {
    return GestureDetector(
      onTap: () => _makePhoneCall(fullNumber),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.phone, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              displayNumber,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Qo\'ng\'iroq',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialCard(String title, String handle, IconData icon,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              handle,
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
      String title, String content, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            content,
            textAlign: TextAlign.center,
            style:
                TextStyle(fontSize: 11, color: Colors.grey[700], height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceChip(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
