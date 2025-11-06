class PanelModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double power;
  final double efficiency;
  final String warranty;
  final double price;
  final List<String> features;

  PanelModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.power,
    required this.efficiency,
    required this.warranty,
    required this.price,
    required this.features,
  });

  factory PanelModel.fromJson(Map<String, dynamic> json) {
    return PanelModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      power: (json['power'] ?? 0).toDouble(),
      efficiency: (json['efficiency'] ?? 0).toDouble(),
      warranty: json['warranty'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      features: List<String>.from(json['features'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'power': power,
      'efficiency': efficiency,
      'warranty': warranty,
      'price': price,
      'features': features,
    };
  }
}

class PricingModel {
  final String id;
  final String packageName;
  final String description;
  final double price;
  final String duration;
  final List<String> includes;
  final bool isPopular;

  PricingModel({
    required this.id,
    required this.packageName,
    required this.description,
    required this.price,
    required this.duration,
    required this.includes,
    required this.isPopular,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      id: json['id'] ?? '',
      packageName: json['packageName'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
      includes: List<String>.from(json['includes'] ?? []),
      isPopular: json['isPopular'] ?? false,
    );
  }
}

class ContactModel {
  final String phone;
  final String email;
  final String address;
  final String workingHours;
  final Map<String, String> socialMedia;

  ContactModel({
    required this.phone,
    required this.email,
    required this.address,
    required this.workingHours,
    required this.socialMedia,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      address: json['address'] ?? '',
      workingHours: json['workingHours'] ?? '',
      socialMedia: Map<String, String>.from(json['socialMedia'] ?? {}),
    );
  }
}

class SolarPanel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double power;
  final String efficiency;
  final String warranty;
  final String imageUrl;

  SolarPanel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.power,
    required this.efficiency,
    required this.warranty,
    this.imageUrl = '',
  });
}

// Real quyosh paneli ma'lumotlari
class SolarPanelData {
  static List<SolarPanel> getPanels() {
    return [
      // Quyosh panellari tizimi - quvvat bo'yicha
      SolarPanel(
        id: '1',
        name: 'LONGi Hi-MO 6 10kW Tizim',
        description:
            'LONGi Hi-MO 6 seriyasi, 10kW to\'liq tizim. N-type TOPCon texnologiya, 21.8% samaradorlik.',
        price: 6300, // $6300
        power: 10000,
        efficiency: '21.8%',
        warranty: '25 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-15-58.jpg',
      ),
      SolarPanel(
        id: '2',
        name: 'LONGi Hi-MO 6 20kW Tizim',
        description:
            'LONGi Hi-MO 6 seriyasi, 20kW tizim. Bifacial texnologiya, yuqori energiya ishlab chiqarish.',
        price: 11800, // $11800
        power: 20000,
        efficiency: '22.0%',
        warranty: '25 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-02.jpg',
      ),
      SolarPanel(
        id: '3',
        name: 'LONGi Hi-MO 7 30kW Tizim',
        description:
            'LONGi Hi-MO 7 seriyasi, 30kW tizim. Yangi avlod N-type texnologiya, 22.5% samaradorlik.',
        price: 17300, // $17300
        power: 30000,
        efficiency: '22.5%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-06.jpg',
      ),
      SolarPanel(
        id: '4',
        name: 'LONGi Hi-MO 7 40kW Tizim',
        description:
            'LONGi Hi-MO 7 seriyasi, 40kW tizim. Premium sifat, yuqori ishonchlilik.',
        price: 22000, // $22000
        power: 40000,
        efficiency: '22.6%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-08.jpg',
      ),
      SolarPanel(
        id: '5',
        name: 'LONGi Hi-MO X6 50kW Tizim',
        description:
            'LONGi Hi-MO X6 seriyasi, 50kW tizim. Maksimal quvvat, tijorat uchun ideal.',
        price: 26800, // $26800
        power: 50000,
        efficiency: '22.8%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-10.jpg',
      ),
      SolarPanel(
        id: '6',
        name: 'LONGi Hi-MO X6 60kW Tizim',
        description:
            'LONGi Hi-MO X6 seriyasi, 60kW tizim. Katta tijorat obyektlari uchun.',
        price: 31500, // $31500
        power: 60000,
        efficiency: '23.0%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-12.jpg',
      ),
      SolarPanel(
        id: '7',
        name: 'LONGi Hi-MO X6 70kW Tizim',
        description:
            'LONGi Hi-MO X6 seriyasi, 70kW tizim. Sanoat obyektlari uchun professional yechim.',
        price: 36200, // $36200
        power: 70000,
        efficiency: '23.1%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-13.jpg',
      ),
      SolarPanel(
        id: '8',
        name: 'LONGi Hi-MO X6 80kW Tizim',
        description:
            'LONGi Hi-MO X6 seriyasi, 80kW tizim. Katta sanoat uchun yuqori quvvat.',
        price: 41000, // $41000
        power: 80000,
        efficiency: '23.2%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-15-58.jpg',
      ),
      SolarPanel(
        id: '9',
        name: 'LONGi Hi-MO X6 90kW Tizim',
        description:
            'LONGi Hi-MO X6 seriyasi, 90kW tizim. Enterprise level yechim.',
        price: 45700, // $45700
        power: 90000,
        efficiency: '23.3%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-02.jpg',
      ),
      SolarPanel(
        id: '10',
        name: 'LONGi Hi-MO X6 100kW Tizim',
        description:
            'LONGi Hi-MO X6 seriyasi, 100kW tizim. Zavod va fabrikalar uchun maksimal quvvat.',
        price: 50400, // $50400
        power: 100000,
        efficiency: '23.4%',
        warranty: '30 yil',
        imageUrl: 'assets/images/inverters/photo_2025-11-05_15-16-06.jpg',
      ),
    ];
  }
}
