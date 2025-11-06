// Buyurtma modeli
class OrderModel {
  final String id;
  final String customerName;
  final String phoneNumber;
  final String address;
  final String panelType;
  final int quantity;
  final String? inverterType;
  final String? additionalInfo;
  final DateTime orderDate;
  final String status; // pending, confirmed, completed, cancelled

  OrderModel({
    required this.id,
    required this.customerName,
    required this.phoneNumber,
    required this.address,
    required this.panelType,
    required this.quantity,
    this.inverterType,
    this.additionalInfo,
    required this.orderDate,
    this.status = 'pending',
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? '',
      customerName: json['customerName'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      address: json['address'] ?? '',
      panelType: json['panelType'] ?? '',
      quantity: json['quantity'] ?? 1,
      inverterType: json['inverterType'],
      additionalInfo: json['additionalInfo'],
      orderDate:
          DateTime.parse(json['orderDate'] ?? DateTime.now().toIso8601String()),
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'phoneNumber': phoneNumber,
      'address': address,
      'panelType': panelType,
      'quantity': quantity,
      'inverterType': inverterType,
      'additionalInfo': additionalInfo,
      'orderDate': orderDate.toIso8601String(),
      'status': status,
    };
  }
}
