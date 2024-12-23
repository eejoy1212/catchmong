class Partner {
  final int id;
  final String name;
  final double? latitude; // 위도
  final double? longitude; // 경도
  final String? qrCode; // QR 코드
  final String? description; // 설명
  final int? regionId; // 지역 ID
  final String foodType; // 업태 (한식, 중식 등)
  final String category; // 카테고리 (데이트 맛집 등)
  final List<String>? businessProofs; // 사업자 등록증 외 증빙서류 (사진 경로 리스트)
  final List<String>? storePhotos; // 업체 사진 (사진 경로 리스트)
  final String address; // 주소
  final String phone; // 가게 전화번호
  final List<String>? amenities; // 편의시설 (주차, 쿠폰 등)
  final bool hasHoliday; // 휴무일 여부
  final String? regularHoliday; // 정기 휴무일
  final String businessTimeConfig; // 영업시간 설정 방식
  final String? businessTime; // 영업시간
  final String? breakTime; // 휴게시간
  final DateTime createdAt; // 생성 날짜
  final DateTime updatedAt; // 업데이트 날짜

  Partner({
    required this.id,
    required this.name,
    this.latitude,
    this.longitude,
    this.qrCode,
    this.description,
    this.regionId,
    required this.foodType,
    required this.category,
    this.businessProofs,
    this.storePhotos,
    required this.address,
    required this.phone,
    this.amenities,
    required this.hasHoliday,
    this.regularHoliday,
    required this.businessTimeConfig,
    this.businessTime,
    this.breakTime,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      qrCode: json['qrCode'] as String?,
      description: json['description'] as String?,
      regionId: json['regionId'] as int?,
      foodType: json['foodType'] as String,
      category: json['category'] as String,
      businessProofs: (json['businessProofs'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      storePhotos: (json['storePhotos'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      address: json['address'] as String,
      phone: json['phone'] as String,
      amenities: (json['amenities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      hasHoliday: json['hasHoliday'] as bool,
      regularHoliday: json['regularHoliday'] as String?,
      businessTimeConfig: json['businessTimeConfig'] as String,
      businessTime: json['businessTime'] as String?,
      breakTime: json['breakTime'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  // Dart 객체를 JSON 데이터로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'qrCode': qrCode,
      'description': description,
      'regionId': regionId,
      'foodType': foodType,
      'category': category,
      'businessProofs': businessProofs,
      'storePhotos': storePhotos,
      'address': address,
      'phone': phone,
      'amenities': amenities,
      'hasHoliday': hasHoliday,
      'regularHoliday': regularHoliday,
      'businessTimeConfig': businessTimeConfig,
      'businessTime': businessTime,
      'breakTime': breakTime,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
