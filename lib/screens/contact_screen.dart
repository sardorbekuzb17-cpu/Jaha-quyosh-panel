import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen>
    with TickerProviderStateMixin {
  static const String phoneNumber = '+998930874758';
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

  Future<void> _makePhoneCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
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
            const SizedBox(height: 50),

            // Logo yoki rasm
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[900]!, Colors.blue[700]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withValues(alpha: 0.3),
                    spreadRadius: 5,
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: const Icon(
                Icons.phone,
                size: 60,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 30),

            // Sarlavha
            Text(
              'Biz bilan bog\'lanish',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Quyosh paneli yechimlari bo\'yicha\nbarcha savollaringizga javob oling',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),

            const SizedBox(height: 50),

            // Telefon raqami
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  Text(
                    'Telefon raqami',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    phoneNumber,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Qo'ng'iroq qilish tugmasi
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _makePhoneCall,
                icon: const Icon(
                  Icons.phone,
                  size: 28,
                  color: Colors.white,
                ),
                label: const Text(
                  'Qo\'ng\'iroq qilish',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[600],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  shadowColor: Colors.green.withValues(alpha: 0.3),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Telegram
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Column(
                children: [
                  Text(
                    'Telegram',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    't.me/quyosh24_sun24',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Telegram tugmasi
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _openTelegram,
                icon: const Icon(
                  Icons.telegram,
                  size: 28,
                  color: Colors.white,
                ),
                label: const Text(
                  'Telegram ochish',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0088CC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  shadowColor: const Color(0xFF0088CC).withValues(alpha: 0.3),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Instagram
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.pink[50],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.pink[200]!),
              ),
              child: Column(
                children: [
                  Text(
                    'Instagram',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[900],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    '@quyosh24_',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink[900],
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Instagram tugmasi
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: _openInstagram,
                icon: const Icon(
                  Icons.camera_alt,
                  size: 28,
                  color: Colors.white,
                ),
                label: const Text(
                  'Instagram ochish',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE4405F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  shadowColor: const Color(0xFFE4405F).withValues(alpha: 0.3),
                ),
              ),
            ),

            const SizedBox(height: 20),



            const SizedBox(height: 30),

            // Manzil
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.orange[200]!),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 40,
                    color: Colors.orange[900],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Manzil',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange[900],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'NAVOIY VILOYATI\nUCHQUDUQ TUMANI\n13-A28',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Ish vaqti
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 40,
                    color: Colors.blue[900],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Ish vaqti',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Dushanba - Juma: 8:00 - 19:00\nShanba: 9:00 - 17:00\nYakshanba: 10:00 - 15:00',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // Xizmatlar - RGB animatsiya bilan
            AnimatedBuilder(
              animation: _colorController,
              builder: (context, child) {
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(
                            Colors.red, Colors.green, _colorController.value)!,
                        Color.lerp(
                            Colors.green, Colors.blue, _colorController.value)!,
                        Color.lerp(
                            Colors.blue, Colors.red, _colorController.value)!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Color.lerp(Colors.red, Colors.blue,
                                _colorController.value)!
                            .withValues(alpha: 0.3),
                        spreadRadius: 3,
                        blurRadius: 10,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.build_circle,
                        size: 40,
                        color: Colors.white,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Bizning xizmatlar',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        '🔸 Quyosh paneli sotib olish\n'
                        '🔸 Professional o\'rnatish\n'
                        '🔸 Texnik xizmat ko\'rsatish\n'
                        '🔸 Bepul konsultatsiya\n'
                        '🔸 Loyiha ishlab chiqish\n'
                        '🔸 24/7 qo\'llab-quvvatlash\n'
                        '🔸 Kafolat xizmati\n'
                        '🔸 Energiya tejash hisoblash',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.8,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
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
}
