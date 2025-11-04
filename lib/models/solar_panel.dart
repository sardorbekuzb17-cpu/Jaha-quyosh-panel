class SolarPanel {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double power;
  final String efficiency;
  final String warranty;

  SolarPanel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.power,
    required this.efficiency,
    required this.warranty,
  });

  factory SolarPanel.fromJson(Map<String, dynamic> json) {
    return SolarPanel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'].toDouble(),
      imageUrl: json['imageUrl'],
      power: json['power'].toDouble(),
      efficiency: json['efficiency'],
      warranty: json['warranty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'power': power,
      'efficiency': efficiency,
      'warranty': warranty,
    };
  }
}