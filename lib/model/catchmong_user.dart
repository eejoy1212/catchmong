import 'package:catchmong/model/partner.dart';

class User {
  final int id;
  final String name;
  final String email;
  final String nickname;
  final String phone;
  final String gender;
  final String paybackMethod;
  final int? regionId;
  final int? referrerId;
  final String sub;
  final String ageGroup;
  final String? picture;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int totalReviews;
  final int totalImages;
  final List<Partner> scrapPartners; // 새로운 필드 추가

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.nickname,
    required this.phone,
    required this.gender,
    required this.paybackMethod,
    this.regionId,
    this.referrerId,
    required this.sub,
    required this.ageGroup,
    this.picture,
    this.createdAt,
    this.updatedAt,
    required this.totalReviews,
    required this.totalImages,
    required this.scrapPartners, // 생성자에 추가
  });

  // JSON 데이터를 Dart 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int,
      name: json['name'] ?? "알 수 없음",
      email: json['email'] ?? "알 수 없음",
      nickname: json['nickname'] ?? "알 수 없음",
      phone: json['phone'] ?? "없음",
      gender: json['gender'] ?? "비공개",
      paybackMethod: json['paybackMethod'] ?? "바로바로 받기",
      regionId: json['regionId'] != null ? json['regionId'] as int : null,
      referrerId: json['referrerId'] != null ? json['referrerId'] as int : null,
      sub: json['sub'] ?? "",
      ageGroup: json['ageGroup'] ?? "10대",
      picture: json['picture'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : null,
      totalReviews: json['totalReviews'] ?? 0,
      totalImages: json['totalImages'] ?? 0,
      scrapPartners: (json['scrapPartners'] as List<dynamic>? ?? [])
          .map((partner) => Partner.fromJson(partner as Map<String, dynamic>))
          .toList(), // 리스트 변환
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'nickname': nickname,
      'phone': phone,
      'gender': gender,
      'paybackMethod': paybackMethod,
      'regionId': regionId,
      'referrerId': referrerId,
      'sub': sub,
      'ageGroup': ageGroup,
      'picture': picture,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'totalReviews': totalReviews,
      'totalImages': totalImages,
      'scrapPartners':
          scrapPartners.map((partner) => partner.toJson()).toList(), // 리스트 변환
    };
  }
}
