import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/model/partner.dart';

class Reservation {
  final int id; // 예약 ID
  final List<DateTime> reservationDate; // 예약 날짜
  final DateTime createdAt; // 예약 날짜
  final DateTime updatedAt; // 예약 날짜
  final int numOfPeople; // 예약 인원수
  final String? request; // 요청 사항
  final String status; // 예약 상태
  final Partner partner; // 예약된 파트너 정보
  final User? user; // 예약된 파트너 정보
  Reservation({
    required this.id,
    required this.reservationDate,
    required this.createdAt,
    required this.updatedAt,
    required this.numOfPeople,
    this.request,
    required this.status,
    required this.partner,
    this.user,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
      id: json['id'],
      // List<String> -> List<DateTime>으로 변환
      reservationDate: (json['reservationDate'] as List<dynamic>)
          .map((date) => DateTime.parse(date as String))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      numOfPeople: json['numOfPeople'],
      request: json['request'],
      status: json['status'],
      partner: Partner.fromJson(json['partners']), // Partner 객체 생성
      user: User.fromJson(json['users']), // Partner 객체 생성
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      // List<DateTime> -> List<String>으로 변환
      'reservationDate':
          reservationDate.map((date) => date.toIso8601String()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'numOfPeople': numOfPeople,
      'request': request,
      'status': status,
      'partners': partner.toJson(),
      'users': user?.toJson(),
    };
  }
}
