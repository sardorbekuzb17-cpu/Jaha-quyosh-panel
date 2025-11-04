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
