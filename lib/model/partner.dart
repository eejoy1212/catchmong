class Partner {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String? qrCode;
  final DateTime createdAt;
  final DateTime updatedAt;

  Partner({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    this.qrCode,
    required this.createdAt,
    required this.updatedAt,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory Partner.fromJson(Map<String, dynamic> json) {
    return Partner(
      id: json['id'] as int,
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      qrCode: json['qrCode'] as String?,
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
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
