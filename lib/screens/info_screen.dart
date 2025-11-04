import 'package:flutter/material.dart';
import 'package:solar_panel_info/widgets/info_card.dart';
import 'faq_screen.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Quyosh Energiyasi Haqida',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            InfoCard(
              title: 'Quyosh Energiyasi Nima?',
              content:
                  'Quyosh energiyasi quyosh nurlaridan olinadigan toza, qayta tiklanuvchi energiya manbasidir. Bu energiya quyosh panelari yordamida elektr energiyaga aylantiriladi.',
              icon: Icons.wb_sunny,
            ),
            SizedBox(height: 20),
            InfoCard(
              title: 'Afzalliklari',
              content:
                  '• Atrof-muhitga zarar bermaydi\n• Uzoq muddatli investitsiya\n• Kam xizmat ko\'rsatish talabi\n• Energiya narxlaridan mustaqillik',
              icon: Icons.check_circle,
            ),
            SizedBox(height: 20),
            InfoCard(
              title: 'Qanday Ishlaydi?',
              content:
                  'Quyosh panelari quyosh nurlarini elektr energiyaga aylantiradi. Bu energiya uy tarmog\'iga ulanadi va uy elektr jihozlari uchun foydalaniladi.',
              icon: Icons.settings,
            ),
            SizedBox(height: 20),
            InfoCard(
              title: 'Tejamkorlik',
              content:
                  'O\'rta hajmli tizim 20 yil davomida 30-50 million so\'m tejash imkonini beradi. Bu energiya hisobini sezilarli darajada kamaytiradi.',
              icon: Icons.savings,
            ),
            const SizedBox(height: 20),
            InfoCard(
              title: 'O\'zbekistonda quyosh energiyasi',
              content:
                  'O\'zbekiston yiliga 320 kun quyoshli kun bor. Bu quyosh panellari uchun ideal sharoit yaratadi. Davlat tomonidan qo\'llab-quvvatlash dasturlari mavjud.',
              icon: Icons.wb_sunny,
            ),
            const SizedBox(height: 20),
            InfoCard(
              title: 'Texnik xizmat',
              content:
                  'Quyosh panellari minimal texnik xizmat talab qiladi. Yiliga 1-2 marta tozalash va tekshirish kifoya. 25 yilgacha kafolat beriladi.',
              icon: Icons.build,
            ),
            const SizedBox(height: 32),

            // FAQ tugmasi
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.orange[400]!, Colors.orange[600]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.quiz,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Savollaringiz bormi?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tez-tez so\'raladigan savollar bo\'limida javoblarni toping',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const FAQScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.orange[600],
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'FAQ ko\'rish',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
}
