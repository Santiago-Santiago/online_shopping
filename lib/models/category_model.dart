import 'dart:convert';

class Category {
  final String code;
  final String type;
  final String description;
  final String image_url;
  final String status;

  Category({
    required this.code,
    required this.type,
    required this.description,
    required this.image_url,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'type': type,
      'description': description,
      'image_url': image_url,
      'status': status,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      code: map['code'],
      type: map['type'],
      description: map['description'],
      image_url: map['image_url'],
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
