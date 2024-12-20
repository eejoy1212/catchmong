class Partner {
  final int id;
  final String name;
  final double? latitude; // Null 허용 (위도)
  final double? longitude; // Null 허용 (경도)
  final String? qrCode; // QR 코드
  final String? description; // 설명 (nullable)
  final int? regionId; // 지역 ID (nullable)
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
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory Partner.fromJson(Map<String, dynamic> json) {
    // 위도와 경도 값을 0으로 받은 경우 0.0으로 변환
    final latitude = (json['latitude'] as num?)?.toDouble() ?? 0.0;
    final longitude = (json['longitude'] as num?)?.toDouble() ?? 0.0;

    return Partner(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: latitude == 0 ? 0.0 : latitude, // 0을 0.0으로 변환
      longitude: longitude == 0 ? 0.0 : longitude, // 0을 0.0으로 변환
      qrCode: json['qrCode'] as String?,
      description: json['description'] as String?,
      regionId: json['regionId'] as int?,
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
