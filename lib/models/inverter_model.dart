class Inverter {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double power; // kW
  final String efficiency;
  final String warranty;
  final String type; // String, Grid-tie, Hybrid
  final List<String> features;
  final String imageUrl;

  Inverter({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    required this.power,
    required this.efficiency,
    required this.warranty,
    required this.type,
    required this.features,
    required this.imageUrl,
  });

  factory Inverter.fromJson(Map<String, dynamic> json) {
    return Inverter(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      brand: json['brand'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      power: (json['power'] ?? 0).toDouble(),
      efficiency: json['efficiency'] ?? '',
      warranty: json['warranty'] ?? '',
      type: json['type'] ?? '',
      features: List<String>.from(json['features'] ?? []),
      imageUrl: json['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'description': description,
      'price': price,
      'power': power,
      'efficiency': efficiency,
      'warranty': warranty,
      'type': type,
      'features': features,
      'imageUrl': imageUrl,
    };
  }
}

// Real inverter ma'lumotlari
class InverterData {
  static List<Inverter> getInverters() {
    return [
      Inverter(
        id: '1',
        name: 'Huawei SUN2000-5KTL-M1',
        brand: 'Huawei',
        description:
            'Yuqori samaradorlikka ega inverter, uy va kichik biznes uchun ideal.',
        price: 8500000, // 8.5M so'm
        power: 5.0,
        efficiency: '98.4%',
        warranty: '10 yil',
        type: 'Inverter',
        features: [
          'Wi-Fi monitoring',
          'Smart I-V diagnostika',
          'AFCI himoya',
          'IP65 himoya darajasi',
          'Keng kuchlanish diapazoni'
        ],
        imageUrl: 'assets/images/inverters/34062.jpg',
      ),
      Inverter(
        id: '2',
        name: 'SolarEdge SE5000H-RWS',
        brand: 'SolarEdge',
        description: 'Inverter batareya saqlash imkoniyati bilan.',
        price: 12000000, // 12M so'm
        power: 5.0,
        efficiency: '97.3%',
        warranty: '12 yil',
        type: 'Inverter',
        features: [
          'Batareya integratsiyasi',
          'Backup quvvat',
          'SafeDC texnologiyasi',
          'Monitoring platformasi',
          'Kengaytirilishi mumkin'
        ],
        imageUrl:
            'assets/images/inverters/goodwe25kw_3c045e2e-2321-4740-a5cd-c4ff7f0e7203.webp',
      ),
      Inverter(
        id: '3',
        name: 'Fronius Primo 6.0-1',
        brand: 'Fronius',
        description: 'Avstriya ishlab chiqargan yuqori sifatli inverter.',
        price: 9800000, // 9.8M so'm
        power: 6.0,
        efficiency: '98.1%',
        warranty: '5 yil',
        type: 'Inverter',
        features: [
          'SnapINverter texnologiyasi',
          'Integrated data communication',
          'Dynamic Peak Manager',
          'Tundra texnologiyasi',
          'Oson o\'rnatish'
        ],
        imageUrl:
            'assets/images/inverters/inversor-solar-trifasico-goodwe-gw30k-mt.jpg',
      ),
      Inverter(
        id: '4',
        name: 'Growatt SPH 6000TL3 BH',
        brand: 'Growatt',
        description: 'Uch fazali inverter katta uylar uchun.',
        price: 15000000, // 15M so'm
        power: 6.0,
        efficiency: '97.6%',
        warranty: '10 yil',
        type: 'Inverter',
        features: [
          'Uch fazali chiqish',
          'Batareya boshqaruvi',
          'EPS funksiyasi',
          'Wi-Fi monitoring',
          'Parallel ishlash'
        ],
        imageUrl: 'assets/images/inverters/SDTG217-25kW-红色（有屏）-1.png',
      ),
      Inverter(
        id: '5',
        name: 'Sungrow SG10RT',
        brand: 'Sungrow',
        description: 'Katta quvvatli inverter tijorat obyektlari uchun.',
        price: 18000000, // 18M so'm
        power: 10.0,
        efficiency: '98.5%',
        warranty: '10 yil',
        type: 'Inverter',
        features: [
          'Yuqori quvvat zichligi',
          'Smart O&M',
          'Type II SPD',
          'Keng harorat diapazoni',
          'Oson texnik xizmat'
        ],
        imageUrl:
            'assets/images/inverters/sungrow-wr-front-93a341701c3a51bebed934a797b01891.png',
      ),
      Inverter(
        id: '6',
        name: 'Goodwe GW5048D-ES',
        brand: 'GoodWe',
        description: 'Batareya bilan ishlash uchun mo\'ljallangan inverter.',
        price: 11500000, // 11.5M so'm
        power: 5.0,
        efficiency: '97.8%',
        warranty: '10 yil',
        type: 'Inverter',
        features: [
          'Lithium batareya qo\'llab-quvvatlash',
          'UPS funksiyasi',
          'Smart Load Management',
          'Remote monitoring',
          'Parallel connection'
        ],
        imageUrl: 'assets/images/inverters/sets2_.jpg',
      ),
    ];
  }
}
