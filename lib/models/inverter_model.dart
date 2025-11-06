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
        name: 'Sungrow 10kW',
        brand: 'Sungrow',
        description: '10kW quvvatli inverter, uylar va kichik biznes uchun.',
        price: 4000, // $4000 (dollar narxi)
        power: 10.0,
        efficiency: '98.5%',
        warranty: '10 yil',
        type: 'String Inverter',
        features: [
          'Yuqori samaradorlik',
          'Smart monitoring',
          'IP65 himoya',
          'Keng kuchlanish diapazoni',
          'Oson o\'rnatish'
        ],
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-15-58.jpg',
      ),
      Inverter(
        id: '2',
        name: 'Sungrow 15kW',
        brand: 'Sungrow',
        description: '15kW quvvatli inverter, o\'rta biznes uchun.',
        price: 5200, // $5200 (dollar narxi)
        power: 15.0,
        efficiency: '98.6%',
        warranty: '10 yil',
        type: 'String Inverter',
        features: [
          'Yuqori quvvat',
          'Smart O&M',
          'Type II SPD',
          'Wi-Fi monitoring',
          'Parallel ishlash'
        ],
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-02.jpg',
      ),
      Inverter(
        id: '3',
        name: 'Sungrow 20kW',
        brand: 'Sungrow',
        description: '20kW quvvatli inverter, katta uylar va biznes uchun.',
        price: 6800, // $6800 (dollar narxi)
        power: 20.0,
        efficiency: '98.7%',
        warranty: '10 yil',
        type: 'String Inverter',
        features: [
          'Yuqori quvvat zichligi',
          'Smart diagnostika',
          'Remote monitoring',
          'Keng harorat diapazoni',
          'Professional xizmat'
        ],
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-06.jpg',
      ),
      Inverter(
        id: '4',
        name: 'Sungrow 50kW',
        brand: 'Sungrow',
        description: '50kW quvvatli inverter, tijorat obyektlari uchun.',
        price: 12000, // $12000 (dollar narxi)
        power: 50.0,
        efficiency: '98.8%',
        warranty: '10 yil',
        type: 'String Inverter',
        features: [
          'Yuqori quvvat',
          'Smart O&M platformasi',
          'Type II SPD himoya',
          'Keng kuchlanish diapazoni',
          '24/7 monitoring'
        ],
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-08.jpg',
      ),
      Inverter(
        id: '5',
        name: 'Sungrow 110kW',
        brand: 'Sungrow',
        description: '110kW quvvatli inverter, katta tijorat obyektlari uchun.',
        price: 22000, // $22000 (dollar narxi)
        power: 110.0,
        efficiency: '98.9%',
        warranty: '10 yil',
        type: 'String Inverter',
        features: [
          'Maksimal quvvat',
          'Professional monitoring',
          'Advanced diagnostika',
          'Keng harorat diapazoni',
          'Enterprise support'
        ],
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-10.jpg',
      ),
    ];
  }
}
