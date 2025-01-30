import 'dart:convert';

import 'package:catchmong/model/temp_closure.dart';

import 'review.dart'; // Review 클래스가 정의된 파일 경로를 import
import 'menu.dart'; // Menu 클래스가 정의된 파일 경로를 import

class Partner {
  final int? id;
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
  final List<Review>? reviews; // 리뷰 리스트
  final List<Menu>? menus; // 메뉴 리스트
  final int? reviewCount; // 리뷰 개수
  final TempClosure? tempClosure; // 임시 휴무 정보 추가
  Partner({
    this.id,
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
    this.reviews, // 리뷰 리스트 초기화
    this.menus, // 메뉴 리스트 초기화
    this.reviewCount, // 리뷰 개수 초기화
    this.tempClosure, // TempClosure 추가
  });
  factory Partner.fromJson(Map<String, dynamic> json) {
    print("storePhotos type>>> ${json["storePhotos"].runtimeType}");
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
      businessProofs: _autoConvertToListOfString(json['businessProofs']),
      storePhotos: _autoConvertToListOfString(json['storePhotos']), // 자동 변환 추가
      address: json['address'] as String,
      phone: json['phone'] as String,
      amenities: _autoConvertToListOfString(json['amenities']),
      hasHoliday: json['hasHoliday'] as bool,
      regularHoliday: json['regularHoliday'] as String?,
      businessTimeConfig: json['businessTimeConfig'] as String,
      businessTime: json['businessTime'] as String?,
      breakTime: json['breakTime'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      menus: (json['menus'] as List<dynamic>?)
          ?.map((e) => Menu.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewCount: json['reviewCount'] as int?,
      tempClosure: json['tempClosure'] != null
          ? TempClosure.fromJson(json['tempClosure'])
          : null, // TempClosure 처리
    );
  }
  static List<String>? _autoConvertToListOfString(dynamic field) {
    if (field == null) {
      return null; // null 처리
    } else if (field is String) {
      // JSON 형식으로 인코딩된 리스트인지 확인
      if (field.startsWith('[') && field.endsWith(']')) {
        try {
          List<dynamic> decoded = jsonDecode(field); // JSON 디코딩
          return decoded.map((e) => e.toString()).toList(); // String 리스트로 변환
        } catch (e) {
          throw Exception('Invalid JSON format for List<String>: $field');
        }
      }
      return [field]; // 단일 문자열을 리스트로 변환
    } else if (field is List<String>) {
      return field; // 이미 List<String>인 경우 그대로 반환
    } else if (field is List) {
      return field.map((e) => e.toString()).toList(); // 리스트의 요소를 문자열로 변환
    } else {
      throw Exception('Invalid format for List<String>: $field');
    }
  }

// 헬퍼 함수 _toListOfString
  static List<String>? _toListOfString(dynamic field) {
    if (field == null) {
      return null; // null 처리
    } else if (field is String) {
      return [field]; // 단일 문자열을 리스트로 변환
    } else if (field is List<String>) {
      return field; // 이미 List<String>인 경우 그대로 반환
    } else if (field is List) {
      return field.map((e) => e.toString()).toList(); // 리스트의 요소를 문자열로 변환
    } else {
      throw Exception('Invalid format for List<String>: $field');
    }
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
      'reviews': reviews?.map((e) => e.toJson()).toList(), // 리뷰 리스트 처리
      'menus': menus?.map((e) => e.toJson()).toList(), // 메뉴 리스트 처리
      'reviewCount': reviewCount, // 리뷰 개수 처리
      'tempClosure': tempClosure?.toJson(), // TempClosure JSON 변환
    };
  }
}
