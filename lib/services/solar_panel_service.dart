import 'package:solar_panel_info/models/solar_panel.dart';

class SolarPanelService {
  // Sample data for solar panels
  static List<SolarPanel> getSolarPanels() {
    return [
      SolarPanel(
        id: '1',
        name: 'Monokristall quyosh paneli',
        description: 'Yuqori samarali monokristall quyosh paneli. Uy yoki ofis uchun ideal tanlov.',
        price: 1500000.0,
        imageUrl: 'assets/mono_panel.jpg',
        power: 450.0,
        efficiency: '21.5%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '2',
        name: 'Polikristall quyosh paneli',
        description: 'O\'rta samarali polikristall quyosh paneli. Iqtisodiy variant.',
        price: 1200000.0,
        imageUrl: 'assets/poly_panel.jpg',
        power: 400.0,
        efficiency: '19.2%',
        warranty: '20 yil',
      ),
      SolarPanel(
        id: '3',
        name: 'Thin-film quyosh paneli',
        description: 'Yengil va moslashuvchan thin-film panel. Maxsus ilovalar uchun.',
        price: 1000000.0,
        imageUrl: 'assets/thin_film_panel.jpg',
        power: 300.0,
        efficiency: '15.8%',
        warranty: '15 yil',
      ),
      SolarPanel(
        id: '4',
        name: 'Bifacial quyosh paneli',
        description: 'Ikki tomonlama ishlaydigan ilg\'or panel. Maksimal energiya hosili uchun.',
        price: 2000000.0,
        imageUrl: 'assets/bifacial_panel.jpg',
        power: 500.0,
        efficiency: '23.1%',
        warranty: '30 yil',
      ),
    ];
  }

  static List<Map<String, dynamic>> getFaqItems() {
    return [
      {
        'question': 'Quyosh paneli nima?',
        'answer': 'Quyosh paneli quyosh nuridan elektr energiya hosil qiluvchi qurilma. U quyosh elementlari deb ataladigan fotovoltaik hujayralardan tashkil topgan.'
      },
      {
        'question': 'Quyosh paneli qancha energiya ishlab chiqaradi?',
        'answer': 'Panelning energiya ishlab chiqarishi uning kuchi va samaradorligiga bog\'liq. O\'rta hisobda 400-500 watt quvvatga ega panel kuniga 1.5-3 kWh energiya ishlab chiqaradi.'
      },
      {
        'question': 'Quyosh paneli uchun qancha investitsiya kerak?',
        'answer': 'O\'rta hajmli uy uchun to\'liq tizim narxi 10-20 million so\'mni tashkil qiladi. Bu 5-10 kW tizim uchun, o\'rnatish va boshqa xarajatlarni hisobga olgan holda.'
      },
      {
        'question': 'Quyosh paneli qancha muddat xizmat qiladi?',
        'answer': 'Zavod kafolati odatda 20-25 yil. Biroq, panel 30 yil va undan ortiq muddat xizmat qilishi mumkin, albatta, uning samaradorligi vaqt o\'tishi bilan pasayadi.'
      },
      {
        'question': 'Quyosh paneli o\'rnatish uchun qanday hujjatlar kerak?',
        'answer': 'O\'rnatish uchun elektr tarmoq kompaniyasidan ruxsatnomalar, shuningdek, mahalliy hokimiyatdan ruxsatnomalar talab qilinadi. Professional o\'rnatuvchi barcha hujjatlarni yig\'ishga yordam beradi.'
      },
    ];
  }
}