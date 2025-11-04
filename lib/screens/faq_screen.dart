import 'package:flutter/material.dart';

class FAQScreen extends StatefulWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  _FAQScreenState createState() => _FAQScreenState();
}

class _FAQScreenState extends State<FAQScreen> {
  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'Quyosh panellari qancha vaqt ishlaydi?',
      answer:
          'Sifatli quyosh panellari 25-30 yil ishlaydi. Ko\'pchilik ishlab chiqaruvchilar 25 yillik kafolat beradi. Bu vaqt davomida panel samaradorligi 80% dan kam bo\'lmaydi.',
    ),
    FAQItem(
      question: 'Quyosh panellari bulutli kunlarda ishlaydimi?',
      answer:
          'Ha, quyosh panellari bulutli kunlarda ham ishlaydi, lekin samaradorligi kamayadi. Bulutli kunda panellar normal quvvatining 10-25% ini ishlab chiqaradi.',
    ),
    FAQItem(
      question: 'O\'rnatish qancha vaqt oladi?',
      answer:
          'Uy uchun oddiy tizimni o\'rnatish 1-3 kun vaqt oladi. Katta tijorat tizimlar uchun 1-2 hafta kerak bo\'lishi mumkin. Bu tom murakkabligiga bog\'liq.',
    ),
    FAQItem(
      question: 'Quyosh panellari qishda ishlaydimi?',
      answer:
          'Ha, quyosh panellari qishda ham yaxshi ishlaydi. Hatto sovuq havoda panellar samaraliroq ishlaydi. Qor panellardan oson sirg\'ib ketadi.',
    ),
    FAQItem(
      question: 'Texnik xizmat qanday amalga oshiriladi?',
      answer:
          'Quyosh panellari minimal texnik xizmat talab qiladi. Yiliga 1-2 marta suv bilan yuvish va vizual tekshirish kifoya. Professional tekshiruv 3-5 yilda bir marta.',
    ),
    FAQItem(
      question: 'Elektr tarmog\'iga ulash mumkinmi?',
      answer:
          'Ha, O\'zbekistonda net-metering tizimi mavjud. Ortiqcha energiyani elektr tarmog\'iga sotish mumkin. Buning uchun maxsus ruxsat kerak.',
    ),
    FAQItem(
      question: 'Quyosh panellari xavfsizmi?',
      answer:
          'Ha, quyosh panellari mutlaqo xavfsiz. Ular past voltajda ishlaydi va to\'g\'ri o\'rnatilganda hech qanday xavf tug\'dirmaydi. Barcha tizimlar himoya qurilmalari bilan jihozlanadi.',
    ),
    FAQItem(
      question: 'Investitsiya qachon qaytadi?',
      answer:
          'O\'zbekistonda quyosh panellariga investitsiya 6-10 yilda qaytadi. Bu elektr narxi va tizim hajmiga bog\'liq. Keyingi 15-20 yil toza foyda.',
    ),
    FAQItem(
      question: 'Kafolat qanday ishlaydi?',
      answer:
          'Panel ishlab chiqaruvchilar 25 yillik quvvat kafolatini beradi. O\'rnatish ishlariga 2-5 yillik kafolat beriladi. Inverterlar uchun 10-15 yillik kafolat.',
    ),
    FAQItem(
      question: 'Quyosh panellari atrof-muhitga zararlimi?',
      answer:
          'Yo\'q, quyosh panellari atrof-muhitga zarar bermaydi. Ular CO2 chiqarishni kamaytiradi va qayta ishlanishi mumkin. Ishlab chiqarish energiyasi 1-2 yilda qaytadi.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tez-tez so\'raladigan savollar'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue[700]!, Colors.blue[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 48,
                    color: Colors.white,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Savollaringiz bormi?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Quyosh panellari haqida eng ko\'p so\'raladigan savollar va javoblar',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _faqItems.length,
              itemBuilder: (context, index) {
                return _buildFAQCard(_faqItems[index], index);
              },
            ),

            const SizedBox(height: 32),

            // Qo'shimcha yordam
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.green[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.support_agent,
                          color: Colors.green[700], size: 28),
                      const SizedBox(width: 12),
                      Text(
                        'Qo\'shimcha yordam kerakmi?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[700],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Agar savolingizga javob topmagan bo\'lsangiz, biz bilan bog\'laning:',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.phone, color: Colors.green[600], size: 20),
                      const SizedBox(width: 8),
                      const Text('+998 93 087 47 58'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email, color: Colors.green[600], size: 20),
                      const SizedBox(width: 8),
                      const Text('sardorbekuzb17@gmail.com'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.telegram, color: Colors.green[600], size: 20),
                      const SizedBox(width: 8),
                      const Text('@jahongir_solar'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQCard(FAQItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ExpansionTile(
        leading: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
          ),
        ),
        title: Text(
          item.question,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              item.answer,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({
    required this.question,
    required this.answer,
  });
}
