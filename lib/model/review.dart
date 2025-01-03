import 'package:catchmong/model/catchmong_user.dart';

class Review {
  final int id;
  final int userId;
  final int partnerId;
  final String title;
  final String? content;
  final List<String>? images; // JSON 형태의 이미지 리스트
  final double rating;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final User? user; // User 객체 추가

  Review({
    required this.id,
    required this.userId,
    required this.partnerId,
    required this.title,
    this.content,
    this.images,
    required this.rating,
    required this.createdAt,
    this.updatedAt,
    this.user,
  });

  // JSON 데이터를 Review 객체로 변환하는 팩토리 생성자
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'] as int,
      userId: json['userId'] as int,
      partnerId: json['partnerId'] as int,
      title: json['title'] as String,
      content: json['content'] as String?,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : null,
      rating: (json['rating'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      user: json['user'] != null
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null, // User 데이터 처리
    );
  }

  // Review 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'partnerId': partnerId,
      'title': title,
      'content': content,
      'images': images,
      'rating': rating,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'user': user?.toJson(), // User 데이터 추가
    };
  }
}
