import 'dart:convert';

import 'package:catchmong/model/partner.dart';
import 'package:catchmong/model/review.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Partner2Controller extends GetxController {
  var partners = <Partner>[].obs; // RxList<Partner>
  var isLoading = false.obs; // 로딩 상태
  RxInt currentResPage = 0.obs; // 현재 페이지
  RxInt currentHotPage = 0.obs; // 현재 페이지
  RxString searchKeyword = ''.obs; // 검색어 상태 변수
  String baseUrl = 'http://192.168.200.102:3000'; // API 베이스 URL
  Rxn<Partner> selectedPartner = Rxn<Partner>(); // 선택된 파트너
  RxList<Partner> recentPartners = RxList<Partner>.empty(); // 최근 본 파트너 리스트
  RxList<String> recentSearches = RxList.empty();
  RxList<int> recentLatestPartnerIds = RxList.empty();
  RxList<Partner> favoritePartners = RxList.empty(); // 인기 파트너 리스트
  RxBool isExpanded = false.obs; // 확장 상태
  @override
  void onInit() {
    _loadRecentSearches();
    super.onInit();
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.200.102:3000', // API 베이스 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 제한 시간
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 제한 시간
  ));

  // 최근 검색어 로드
  Future<void> _loadRecentSearches() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches.value = prefs.getStringList('recentSearches') ?? [];
    recentLatestPartnerIds.value = prefs
            .getStringList('recentLatestPartners')
            ?.map((e) => int.parse(e))
            .toList() ??
        [];
  }

  // 검색어 저장
  Future<void> addSearchTerm(String searchTerm) async {
    if (searchTerm.isEmpty) return;
    final prefs = await SharedPreferences.getInstance();

    // 중복 제거 및 최신 검색어 추가
    if (recentSearches.contains(searchTerm)) {
      recentSearches.remove(searchTerm);
    }
    recentSearches.insert(0, searchTerm);

    // 최대 10개까지만 유지
    if (recentSearches.length > 10) {
      recentSearches.value = recentSearches.sublist(0, 10);
    }

    await prefs.setStringList('recentSearches', recentSearches);
  }

  // 최근 본 매장 추가
  Future<void> addLatestPartners(int partnerId) async {
    final prefs = await SharedPreferences.getInstance();

    // 중복 제거 및 최신 검색어 추가
    if (recentLatestPartnerIds.contains(partnerId)) {
      recentLatestPartnerIds.remove(partnerId);
    }
    recentLatestPartnerIds.insert(0, partnerId);

    // 최대 10개까지만 유지
    if (recentLatestPartnerIds.length > 10) {
      recentLatestPartnerIds.value = recentLatestPartnerIds.sublist(0, 10);
    }
    print("파트너 id 추가>>> ${recentLatestPartnerIds}");
    // List<int>를 List<String>으로 변환 후 저장
    List<String> stringList =
        recentLatestPartnerIds.map((e) => e.toString()).toList();
    await prefs.setStringList('recentLatestPartners', stringList);
  }

  Future<void> removeSearchTerm(String searchTerm) async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches.remove(searchTerm);
    await prefs.setStringList('recentSearches', recentSearches);
  }

  Future<void> removeAllSearchTerm() async {
    final prefs = await SharedPreferences.getInstance();
    recentSearches.value = [];
    await prefs.setStringList('recentSearches', recentSearches);
  }

  Future<void> fetchPartnersByKeyword() async {
    try {
      isLoading.value = true; // 로딩 시작
      final response = await _dio.get(
        '/partners/search',
        queryParameters: {'keyword': searchKeyword.value},
      );

      if (response.statusCode == 200) {
        // 응답 데이터가 JSON 배열인지 확인 후 처리
        final List<dynamic> data = response.data;
        print("파트너 dynamic 데이터 조회: ${data}");

        // JSON 배열을 Partner 객체 리스트로 변환
        partners.value = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
        print("파트너 데이터 조회 성공: ${partners.value}");
      } else {
        partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
        print("Error: ${response.statusMessage}");
      }
    } catch (e) {
      partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
      print("파트너 데이터 조회 오류: $e");
    } finally {
      isLoading.value = false; // 로딩 종료
    }
  }

  List<Review> parseReviews(List<String> reviewsJsonList) {
    return reviewsJsonList.map((reviewJson) {
      final Map<String, dynamic> json =
          jsonDecode(reviewJson); // JSON 문자열을 Map으로 변환
      return Review.fromJson(json); // Review 객체로 변환
    }).toList();
  }

  // 파트너 ID 리스트로 데이터 가져오기
  Future<void> fetchPartnersByIds() async {
    try {
      if (recentLatestPartnerIds.isEmpty) {
        return;
      }
      // ID 리스트를 쉼표로 연결된 문자열로 변환
      String idListParam = recentLatestPartnerIds.join(',');

      // GET 요청 보내기
      final response = await _dio.get(
        '/partners/byIds',
        queryParameters: {
          'idList': idListParam, // 쿼리 파라미터 추가
        },
      );

      // 성공적인 응답 처리
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        recentPartners.value = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
        print("파트너 데이터 id매칭>>> ${recentPartners[0].storePhotos}");
      } else {
        throw Exception('Failed to load partners: ${response.statusCode}');
      }
    } catch (e) {
      print('파트너 데이터를 가져오는 중 오류 발생: $e');
      throw Exception('Failed to fetch partners: $e');
    }
  }

  double getAverageRating(List<Review>? reviews) {
    if (reviews == null || reviews.isEmpty) {
      return 0;
    }
    double rating = 0;
    if (reviews != null && reviews.isNotEmpty) {
      print('getReviews>>${reviews}');
      for (var review in reviews) {
        rating += review.rating;
      }
      rating = rating / reviews.length;
    }
    return rating;
  }

//인기 매장 top 10
  Future<void> fetchFavoritePartners() async {
    try {
      if (recentLatestPartnerIds.isEmpty) {
        return;
      }

      // GET 요청 보내기
      final response = await _dio.get(
        '/partners/top-rated',
      );

      // 성공적인 응답 처리
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        favoritePartners.value = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load partners: ${response.statusCode}');
      }
    } catch (e) {
      print('인기 파트너 데이터를 가져오는 중 오류 발생: $e');
      throw Exception('Failed to fetch partners: $e');
    }
  }

  Future<void> fetchLatestPartners() async {
    try {
      isLoading.value = true; // 로딩 시작
      final response = await _dio.get(
        '/partners/search',
        queryParameters: {'keyword': searchKeyword.value},
      );

      if (response.statusCode == 200) {
        // 응답 데이터가 JSON 배열인지 확인 후 처리
        final List<dynamic> data = response.data;
        print("파트너 dynamic 데이터 조회: ${data}");

        // JSON 배열을 Partner 객체 리스트로 변환
        partners.value = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
        print("파트너 데이터 조회 성공: ${partners.value}");
      } else {
        partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
        print("Error: ${response.statusMessage}");
      }
    } catch (e) {
      partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
      print("파트너 데이터 조회 오류: $e");
    } finally {
      isLoading.value = false; // 로딩 종료
    }
  }
}
