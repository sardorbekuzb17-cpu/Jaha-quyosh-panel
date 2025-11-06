// Yangiliklar modeli
class NewsModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final String category;
  final String? link;

  NewsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.category,
    this.link,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      date: json['date'] ?? '',
      category: json['category'] ?? 'Umumiy',
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'date': date,
      'category': category,
      'link': link,
    };
  }
}
