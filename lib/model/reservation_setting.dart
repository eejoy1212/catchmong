import 'dart:convert';

class ReservationSetting {
  final int? partnerId;
  final String name;
  final String? description;
  final String availabilityType; // WEEKDAY, WEEKEND, DAILY 중 하나
  final DateTime startTime; // DateTime 형식
  final DateTime endTime; // DateTime 형식
  final String timeUnit; // THIRTY_MIN, ONE_HOUR
  final int availableTables;
  final String allowedPeople;
  final String? reservationImage; // 이미지 경로

  ReservationSetting({
    this.partnerId,
    required this.name,
    this.description,
    required this.availabilityType,
    required this.startTime,
    required this.endTime,
    required this.timeUnit,
    required this.availableTables,
    required this.allowedPeople,
    this.reservationImage,
  });

  // JSON 데이터를 모델로 변환
  factory ReservationSetting.fromJson(Map<String, dynamic> json) {
    return ReservationSetting(
      partnerId: json['partnerId'],
      name: json['name'],
      description: json['description'],
      availabilityType: json['availabilityType'],
      startTime: DateTime.parse(json['startTime']), // DateTime으로 변환
      endTime: DateTime.parse(json['endTime']), // DateTime으로 변환
      timeUnit: json['timeUnit'],
      availableTables: json['availableTables'],
      allowedPeople: json['allowedPeople'],
      reservationImage: json['reservationImage'],
    );
  }

  // 모델 데이터를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'partnerId': partnerId,
      'name': name,
      'description': description,
      'availabilityType': availabilityType,
      'startTime': startTime.toIso8601String(), // ISO 형식으로 변환
      'endTime': endTime.toIso8601String(), // ISO 형식으로 변환
      'timeUnit': timeUnit,
      'availableTables': availableTables,
      'allowedPeople': allowedPeople,
      'reservationImage': reservationImage,
    };
  }

  // copyWith 메서드
  ReservationSetting copyWith({
    int? partnerId,
    String? name,
    String? description,
    String? availabilityType,
    DateTime? startTime,
    DateTime? endTime,
    String? timeUnit,
    int? availableTables,
    String? allowedPeople,
    String? reservationImage,
  }) {
    return ReservationSetting(
      partnerId: partnerId ?? this.partnerId,
      name: name ?? this.name,
      description: description ?? this.description,
      availabilityType: availabilityType ?? this.availabilityType,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      timeUnit: timeUnit ?? this.timeUnit,
      availableTables: availableTables ?? this.availableTables,
      allowedPeople: allowedPeople ?? this.allowedPeople,
      reservationImage: reservationImage ?? this.reservationImage,
    );
  }
}
