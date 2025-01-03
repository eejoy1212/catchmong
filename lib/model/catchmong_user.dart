class User {
  final int id; // SQL: int
  final String name; // SQL: varchar(255)
  final String email; // SQL: varchar(255)
  final String nickname; // SQL: varchar(255)
  final String phone; // SQL: varchar(20)
  final String gender; // SQL: enum('남성', '여성', '비공개')
  final String paybackMethod; // SQL: varchar(255)
  final int? regionId; // SQL: int (nullable, foreign key)
  final int? referrerId; // SQL: int (nullable, foreign key)
  final String sub; // SQL: varchar(255)
  final String
      ageGroup; // SQL: enum('10대', '20대', '30대', '40대', '50대', '60대', '70대+')
  final String? picture; // SQL: varchar(255)
  final DateTime? createdAt; // SQL: datetime
  final DateTime? updatedAt; // SQL: datetime
  final int totalReviews; // 사용자가 작성한 총 리뷰 수
  final int totalImages; // 사용자가 작성한 총 리뷰 수

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
    required this.totalReviews, // 리뷰 수를 필수로 설정
    required this.totalImages, // 리뷰 수를 필수로 설정
  });

  // JSON 데이터를 Dart 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    print("from json >>> $json");
    return User(
      id: json['id'] as int,
      name: json['name'] ?? "알 수 없음", // null일 경우 기본값
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
      totalReviews: json['totalReviews'] ?? 0, // 리뷰 수 기본값 0
      totalImages: json['totalImages'] ?? 0, // 리뷰 수 기본값 0
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    print("to json ${{
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
      'totalReviews': totalReviews, // 리뷰 수 포함
      'totalImages': totalImages, // 리뷰 수 포함
    }}");
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
      'totalReviews': totalReviews, // 리뷰 수 포함
      'totalImages': totalImages, // 리뷰 수 포함
    };
  }
}
