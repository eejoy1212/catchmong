class Menu {
  final int? id; // 메뉴 ID
  final int partnerId; // 파트너 ID
  final String category; // 메뉴 카테고리 (Appetizer, Main Menu 등)
  final String name; // 메뉴 이름
  final double price; // 메뉴 가격
  final String image; // 메뉴 이미지 경로
  final DateTime createdAt; // 생성 날짜
  final DateTime? updatedAt; // 수정 날짜

  Menu({
    this.id,
    required this.partnerId,
    required this.category,
    required this.name,
    required this.price,
    required this.image,
    required this.createdAt,
    this.updatedAt,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'] as int,
      partnerId: json['partnerId'] as int,
      category: json['category'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
    );
  }

  // Dart 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partnerId': partnerId,
      'category': category,
      'name': name,
      'price': price,
      'image': image,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
