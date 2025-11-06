class SolarAd {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String link;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final String category;
  final double price;
  final Map<String, dynamic>? additionalInfo;

  SolarAd({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.link,
    required this.startDate,
    required this.endDate,
    this.isActive = true,
    required this.category,
    required this.price,
    this.additionalInfo,
  });

  factory SolarAd.fromJson(Map<String, dynamic> json) {
    return SolarAd(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      link: json['link'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      isActive: json['is_active'] as bool? ?? true,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      additionalInfo: json['additional_info'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'link': link,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_active': isActive,
      'category': category,
      'price': price,
      'additional_info': additionalInfo,
    };
  }
}