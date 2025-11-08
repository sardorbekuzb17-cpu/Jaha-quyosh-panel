import 'package:flutter/material.dart';

class LicenseScreen extends StatelessWidget {
  const LicenseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Litsenziya'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo va kompaniya nomi
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        spreadRadius: 2,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.solar_power,
                        size: 60,
                        color: Colors.blue[900],
                      ),
                      const SizedBox(height: 15),
                      Text(
                        'QUYOSH24',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'JAHON GROUP',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Litsenziya matni
              _buildSection(
                'DASTURIY TA\'MINOT LITSENZIYASI',
                '''Bu dasturiy ta'minot (Quyosh24 ilovasi) JAHON GROUP tomonidan ishlab chiqilgan va quyidagi shartlar asosida taqdim etiladi:''',
              ),

              _buildSection(
                '1. FOYDALANISH HUQUQLARI',
                '''• Bu ilova faqat shaxsiy va tijorat maqsadlarida foydalanish uchun mo'ljallangan
• Ilovani o'zgartirish, nusxalash yoki qayta tarqatish taqiqlanadi
• Barcha huquqlar JAHON GROUP kompaniyasiga tegishli''',
              ),

              _buildSection(
                '2. CHEKLOVLAR',
                '''• Ilovani reverse engineering qilish taqiqlanadi
• Kodini o'zgartirish yoki dekompilatsiya qilish mumkin emas
• Tijorat maqsadlarida qayta sotish taqiqlanadi''',
              ),

              _buildSection(
                '3. KAFOLAT VA MAS\'ULIYAT',
                '''• Ilova "bor holda" taqdim etiladi
• JAHON GROUP texnik yordam va yangilanishlarni ta'minlaydi
• Ma'lumotlar xavfsizligi kafolatlanadi''',
              ),

              _buildSection(
                '4. MUALLIFLIK HUQUQI',
                '''© 2025 JAHON GROUP. Barcha huquqlar himoyalangan.

Quyosh paneli yechimlari bo'yicha professional xizmatlar:
• Loyihalash va o'rnatish
• Texnik xizmat ko'rsatish
• Kafolat va qo'llab-quvvatlash''',
              ),

              _buildSection(
                '5. ALOQA MA\'LUMOTLARI',
                '''📞 Telefon: +998 93 087 47 58
✈️ Telegram: @quyosh24_sun24
📧 Instagram: @quyosh24_
📍 Manzil: Navoiy viloyati, Uchquduq tumani, 13-A28

Texnik yordam: 24/7 mavjud''',
              ),

              const SizedBox(height: 30),

              // Qabul qilish tugmasi
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[700]!, Colors.blue[900]!],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    children: [
                      Icon(
                        Icons.verified,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Litsenziya shartlarini qabul qilasiz',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Ilovadan foydalanish orqali',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}