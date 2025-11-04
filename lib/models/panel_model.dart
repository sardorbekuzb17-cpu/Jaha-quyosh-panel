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
      imageUrl: json['image_url'] ?? '',
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
      'image_url': imageUrl,
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
    this.isPopular = false,
  });

  factory PricingModel.fromJson(Map<String, dynamic> json) {
    return PricingModel(
      id: json['id'] ?? '',
      packageName: json['package_name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      duration: json['duration'] ?? '',
      includes: List<String>.from(json['includes'] ?? []),
      isPopular: json['is_popular'] ?? false,
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
      workingHours: json['working_hours'] ?? '',
      socialMedia: Map<String, String>.from(json['social_media'] ?? {}),
    );
  }
}

// SolarPanel class for compatibility
class SolarPanel {
  final String id;
  final String name;
  final String description;
  final double price;
  final double power;
  final String efficiency;
  final String warranty;

  SolarPanel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.power,
    required this.efficiency,
    required this.warranty,
  });
}

// Real quyosh paneli ma'lumotlari
class SolarPanelData {
  static List<SolarPanel> getPanels() {
    return [
      SolarPanel(
        id: '1',
        name: 'JinkoSolar Tiger Neo 540W',
        description:
            'Yuqori samaradorlikka ega N-type monokristalin panel, Tiger Neo seriyasi.',
        price: 3200000, // 3.2M so'm
        power: 540,
        efficiency: '22.3%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '2',
        name: 'Canadian Solar HiKu6 450W',
        description:
            'Ishonchli va samarali monokristalin panel, keng qo\'llaniladi.',
        price: 2800000, // 2.8M so'm
        power: 450,
        efficiency: '21.2%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '3',
        name: 'Trina Solar Vertex S+ 500W',
        description:
            'Vertex seriyasining yuqori quvvatli paneli, bifacial texnologiya.',
        price: 3500000, // 3.5M so'm
        power: 500,
        efficiency: '21.8%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '4',
        name: 'LONGi Hi-MO 5m 540W',
        description:
            'LONGi kompaniyasining eng yangi Hi-MO seriyasi, M10 wafer.',
        price: 3300000, // 3.3M so'm
        power: 540,
        efficiency: '22.1%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '5',
        name: 'JA Solar JAM72S30 450W',
        description:
            'PERC texnologiyali monokristalin panel, yuqori ishonchlilik.',
        price: 2700000, // 2.7M so'm
        power: 450,
        efficiency: '20.9%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '6',
        name: 'First Solar Series 6 Plus',
        description:
            'CdTe thin-film texnologiyasi, yuqori haroratda yaxshi ishlaydi.',
        price: 2200000, // 2.2M so'm
        power: 420,
        efficiency: '19.5%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '7',
        name: 'Hanwha Q CELLS Q.PEAK DUO BLK ML-G10+ 405W',
        description: 'Qora ramkali estetik dizayn, Q.ANTUM DUO texnologiyasi.',
        price: 2900000, // 2.9M so'm
        power: 405,
        efficiency: '20.6%',
        warranty: '25 yil',
      ),
      SolarPanel(
        id: '8',
        name: 'SunPower Maxeon 3 400W',
        description:
            'Premium sifatli panel, eng yuqori samaradorlik va ishonchlilik.',
        price: 4500000, // 4.5M so'm
        power: 400,
        efficiency: '22.6%',
        warranty: '25 yil',
      ),
    ];
  }
}
