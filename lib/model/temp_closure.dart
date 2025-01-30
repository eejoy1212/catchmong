import 'dart:convert';

class TempClosure {
  final int id;
  final int partnerId;
  final String
      type; // Enum으로 정의 가능 (e.g., BUSINESS_HOUR_CHANGE, AWAY, TEMPORARY_CLOSURE)
  final DateTime startDate;
  final DateTime endDate;
  final String? startBusinessTime;
  final String? endBusinessTime;
  final bool isClose;

  TempClosure({
    required this.id,
    required this.partnerId,
    required this.type,
    required this.startDate,
    required this.endDate,
    this.startBusinessTime,
    this.endBusinessTime,
    required this.isClose,
  });

  // JSON -> TempClosure
  factory TempClosure.fromJson(Map<String, dynamic> json) {
    return TempClosure(
      id: json['id'],
      partnerId: json['partnerId'],
      type: json['type'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      startBusinessTime: json['startBusinessTime'],
      endBusinessTime: json['endBusinessTime'],
      isClose: json['isClose'],
    );
  }

  // TempClosure -> JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'partnerId': partnerId,
      'type': type,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'startBusinessTime': startBusinessTime,
      'endBusinessTime': endBusinessTime,
      'isClose': isClose,
    };
  }

  // TempClosure -> String (디버깅 용도)
  @override
  String toString() {
    return jsonEncode(toJson());
  }
}
