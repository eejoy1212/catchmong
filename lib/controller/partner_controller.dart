import 'dart:convert';
import 'dart:io';
import 'package:catchmong/model/menu.dart';
import 'package:http/http.dart' as http;
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/model/review.dart';
import 'package:catchmong/modules/partner/views/partner-show-view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Partner2Controller extends GetxController {
  //메뉴등록
  Rxn<File> menuImg = Rxn();
  RxString selectedMenuCategory = "메인메뉴".obs;
  List<String> menuCaregories = [
    "메인메뉴",
    "사이드",
    "디저트",
  ];
  final TextEditingController menuNameTxtController = TextEditingController();
  final TextEditingController menuPriceTxtController = TextEditingController();
  //전체 리스트를 보내기(원래거+추가된거, 왜냐면 삭제한것도 반영해야해서)
  RxList<Menu> newMenus = RxList.empty();
  //메뉴등록
  var partners = <Partner>[].obs; // RxList<Partner>
  var isLoading = false.obs; // 로딩 상태
  //내 가게
  final TextEditingController partnerNameTxtController =
      TextEditingController();
  final TextEditingController editingPartnerNameTxtController =
      TextEditingController();
  List<String> foodTypes = [
    "선택",
    "한식",
    "중식",
    "일식",
    "양식",
    "분식",
    "패스트푸드",
    "비건식당",
    "디저트카페",
    "뷔페"
  ];
  RxString selectedFoodType = RxString("선택");
  RxString editingSelectedFoodType = RxString("선택");
  List<String> categories = [
    "선택",
    "데이트 맛집",
    "화제의 예능",
    "가족 모임",
    "혼밥",
    "노포",
    "인스타 핫플",
    "룸이 있는",
    "가성비 맛집",
    "레스토랑",
    "미슐랭",
  ];
  RxString selectedCategory = RxString("선택");
  RxString editingSelectedCategory = RxString("선택");
  RxList<XFile> businessProofs = RxList.empty();
  RxList<XFile> editingBusinessProofs = RxList.empty();
  RxList<XFile> storePhotos = RxList.empty();
  RxList<XFile> editingStorePhotos = RxList.empty();
  RxString postCode = RxString("");
  RxString editingPostCode = RxString("");
  RxString address = RxString("");
  RxString editingAddress = RxString("");
  final TextEditingController phoneTxtController = TextEditingController();
  final TextEditingController editingPhoneTxtController =
      TextEditingController();
  final TextEditingController descriptionTxtController =
      TextEditingController();
  final TextEditingController editingDescriptionTxtController =
      TextEditingController();
  Rxn<Partner> editing = Rxn();
  List<String> amenities = [
    "주차",
    "쿠폰",
    "유아시설",
    "애견동반",
    "예약",
    "콜키지",
    "단체석",
    "배달",
    "발렛"
  ];
  final RxList<String> selectedAmenities = RxList.empty();
  final RxList<String> editingSelectedAmenities = RxList.empty();
  final List<String> holidays = [
    "있어요",
    "없어요",
  ];
  final RxBool hasHoliday = RxBool(true);
  final RxBool editingHasHoliday = RxBool(true);
  final List<String> holidayWeeks = [
    "매 주",
    "첫째 주",
    "둘째 주",
    "셋째 주",
    "넷째 주",
  ];
  RxString selectedHolidayWeek = RxString("매 주");
  RxString editingSelectedHolidayWeek = RxString("매 주");
  final List<String> regularHolidays = ["월", "화", "수", "목", "금", "토", "일"];
  RxString selectedRegularHoliday = RxString("");
  RxString editingSelectedRegularHoliday = RxString("");
  List<String> businessTimeConfigs = ["매일 같아요", "평일/주말 달라요", "요일별로 달라요"];
  RxString selectedBusinessTimeConfig = RxString("매일 같아요");
  RxString editingSelectedBusinessTimeConfig = RxString("매일 같아요");
  RxMap<String, List<dynamic>> businessTime = {
    "titles": <dynamic>["영업 시간"], // RxList로 감쌈
    "times": <dynamic>[
      {
        "time": ["10:00", "24:00"],
        "allDay": false,
      },
    ] // RxList로 감쌈
  }.obs;
  RxMap<String, List<dynamic>> editingBusinessTime = {
    "titles": <dynamic>["영업 시간"], // RxList로 감쌈
    "times": <dynamic>[
      {
        "time": ["10:00", "24:00"],
        "allDay": false,
      },
    ] // RxList로 감쌈
  }.obs;
  // RxList<List<String>> businessTime = [
  //   ["10:00", "24:00"]
  // ].obs;
  RxBool isAllDay = false.obs;
  RxBool isHoliday = true.obs;
  //위에 hasHoliday/holidayWeeks/selectedRegularHoliday 에서 조합해서 휴일저장
  RxMap<String, List<dynamic>> holidayTime = {
    "titles": <dynamic>["휴게 시간"], // RxList로 감쌈
    "times": <dynamic>[
      {
        "time": ["10:00", "24:00"],
        "allDay": false,
      },
    ] // RxList로 감쌈
  }.obs;
  RxMap<String, List<dynamic>> editingHolidayTime = {
    "titles": <dynamic>["휴게 시간"], // RxList로 감쌈
    "times": <dynamic>[
      {
        "time": ["10:00", "24:00"],
        "allDay": false,
      },
    ] // RxList로 감쌈
  }.obs;
  // RxList<String> bTitles = ["영업 시간"].obs;
  RxList<String> hTitles = ["휴게 시간"].obs;
  Rxn<Partner> newPartner = Rxn();
  //내 가게
  RxInt currentResPage = 0.obs; // 현재 페이지
  RxInt currentHotPage = 0.obs; // 현재 페이지
  RxString searchKeyword = ''.obs; // 검색어 상태 변수
  String baseUrl = 'http://$myPort:3000'; // API 베이스 URL
  Rxn<Partner> selectedPartner = Rxn<Partner>(); // 선택된 파트너
  RxList<Partner> recentPartners = RxList<Partner>.empty(); // 최근 본 파트너 리스트
  RxList<String> recentSearches = RxList.empty();
  RxList<Partner> userPartners = RxList<Partner>.empty(); //유저의 등록된 가게
  RxList<int> recentLatestPartnerIds = RxList.empty();
  RxList<Partner> favoritePartners = RxList.empty(); // 인기 파트너 리스트
  RxBool isExpanded = false.obs; // 확장 상태
  //마이페이지
  List<String> statisticsItems = [
    "년간",
    "월간",
    "주간",
    "일간",
    "직접선택",
  ];
  RxString selectedStatisticsItem = "직접선택".obs;
  //마이페이지
  @override
  void onInit() {
    _loadRecentSearches();
    super.onInit();
  }

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://$myPort:3000', // API 베이스 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 제한 시간
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 제한 시간
  ));
  // 요일을 숫자로 변환
  int _getDayOfWeek(String day) {
    switch (day) {
      case "월":
        return DateTime.monday;
      case "화":
        return DateTime.tuesday;
      case "수":
        return DateTime.wednesday;
      case "목":
        return DateTime.thursday;
      case "금":
        return DateTime.friday;
      case "토":
        return DateTime.saturday;
      case "일":
        return DateTime.sunday;
      default:
        return -1;
    }
  }

  String getReplyCount(int count) {
    if (count < 1000) {
      return "리뷰 $count";
    } else {
      return "리뷰 999+";
    }
  }

// 특정 주차를 숫자로 변환
  int _getWeekOfMonth(String week) {
    if (week.contains("첫째주")) return 1;
    if (week.contains("둘째주")) return 2;
    if (week.contains("셋째주")) return 3;
    if (week.contains("넷째주")) return 4;
    return -1;
  }

  double getRating(Partner partner) {
    double rating = 0;
    if (partner.reviews != null && partner.reviews!.isNotEmpty) {
      print('getReviews>>${partner.reviews}');
      for (var review in partner.reviews!) {
        rating += review.rating;
      }
      rating = rating / partner.reviews!.length;
    }
    return rating;
  }

  Future<void> updatePartner({
    required int partnerId,
    // String? name,
    // String? address,
    // String? phone,
    // String? description,
    // String? foodType,
    // String? category,
    // double? latitude,
    // double? longitude,
    // String? amenities,
    // bool? hasHoliday,
    // String? businessTimeConfig,
  }) async {
    try {
      if (editing.value == null) return;
      final response = await _dio.put(
        baseUrl + "/partners/$partnerId",
        data: {
          'name': editing.value!.name,
          'address': editing.value!.address,
          'phone': editing.value!.phone,
          'description': editing.value!.description,
          'foodType': editing.value!.foodType,
          'category': editing.value!.category,
          'latitude': editing.value!.latitude,
          'longitude': editing.value!.longitude,
          'amenities': editing.value!.amenities,
          'hasHoliday': editing.value!.hasHoliday,
          'businessTimeConfig': editing.value!.businessTimeConfig,
        },
      );

      if (response.statusCode == 200) {
        print('파트너 수정 성공: ${response.data}');
        // Get.back();
      } else {
        print('파트너 수정 실패: ${response.data}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('서버 응답 오류: ${e.response?.data}');
      } else {
        print('요청 오류: ${e.message}');
      }
    }
  }

  Future<void> addPostPartner({required int userId}) async {
    try {
      final partner = newPartner.value;
      if (partner == null) return;
      final response = await _dio.post(
        baseUrl + "/partners",
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {
          "userId": userId,
          "name": partner.name,
          "address": partner.address,
          "phone": partner.phone,
          "description": partner.description ?? "-",
          "foodType": partner.foodType,
          "category": partner.category,
          "latitude": partner.latitude ?? 37.5665,
          "longitude": partner.longitude ?? 126.978,
          "amenities": partner.amenities,
          "hasHoliday": partner.regularHoliday == null ? false : true,
          "businessTimeConfig": "same",
        },
      );

      if (response.statusCode == 201) {
        // 성공 응답 처리
        print('파트너 등록 성공: ${response.data['message']}');
      } else {
        // 실패 응답 처리
        print('파트너 등록 실패: ${response.data['error']}');
      }
    } on DioException catch (e) {
      // DioException 처리
      if (e.response != null) {
        print('서버 오류: ${e.response?.data}');
      } else {
        print('요청 오류: ${e.message}');
      }
    } catch (e) {
      // 기타 오류 처리
      print('파트너 등록 중 오류 발생: $e');
    }
  }

  String getBusinessStatus(
      String businessTime, String? breakTime, String? regularHoliday) {
    try {
      // 현재 시간 가져오기
      final now = DateTime.now();
      final currentTime = DateFormat("HH:mm").format(now);

      // 시작 시간과 종료 시간 분리
      final times = businessTime.split('~');
      if (times.length != 2) return "마감";
      final startTime = times[0].trim();
      final endTime = times[1].trim();

      // 정규 휴일 처리
      if (regularHoliday != null) {
        final holidays = regularHoliday.split(',');
        for (var holiday in holidays) {
          holiday = holiday.trim();
          if (holiday.contains("매주")) {
            final holidayDay =
                _getDayOfWeek(holiday.replaceAll("매주", "").trim());
            if (now.weekday == holidayDay) {
              return "마감";
            }
          } else if (holiday.contains("첫째주") ||
              holiday.contains("둘째주") ||
              holiday.contains("셋째주") ||
              holiday.contains("넷째주")) {
            final weekOfMonth = (now.day - 1) ~/ 7 + 1;
            final holidayWeek = _getWeekOfMonth(holiday);
            final holidayDay = _getDayOfWeek(holiday.split(' ').last.trim());

            if (weekOfMonth == holidayWeek && now.weekday == holidayDay) {
              return "마감";
            }
          }
        }
      }

      // 브레이크타임 처리
      if (breakTime != null) {
        final breakTimes = breakTime.split('~');
        if (breakTimes.length == 2) {
          final breakStart = breakTimes[0].trim();
          final breakEnd = breakTimes[1].trim();

          // 현재 시간이 브레이크타임 범위에 속하면 "브레이크타임" 반환
          if (currentTime.compareTo(breakStart) >= 0 &&
              currentTime.compareTo(breakEnd) <= 0) {
            return "브레이크타임";
          }
        }
      }

      // 현재 시간이 영업 시간 내에 있으면 "영업중" 반환
      if (currentTime.compareTo(startTime) >= 0 &&
          currentTime.compareTo(endTime) <= 0) {
        return "영업중";
      }

      // 위 조건에 해당하지 않으면 "마감" 반환
      return "마감";
    } catch (e) {
      print("Error parsing businessTime: $e");
      return "마감";
    }
  }

  Future<void> fetchPartnerDetails(int partnerId) async {
    try {
      final response = await _dio.get(baseUrl + "/partners/$partnerId");

      if (response.statusCode == 200) {
        final partner = response.data;
        editing.value = Partner.fromJson(partner);
        if (editing.value != null) {
          editingPartnerNameTxtController.text = editing.value!.name;
          editingSelectedFoodType.value = editing.value!.foodType;
          editingSelectedCategory.value = editing.value!.category;
          editingBusinessProofs.value = editing.value!.businessProofs!
              .map((el) => XFile(baseUrl + "/partners" + "/$el"))
              .toList();
          editingStorePhotos.value = editing.value!.storePhotos!
              .map((el) => XFile(baseUrl + "/partners" + "/$el"))
              .toList();
          editingAddress.value = editing.value!.address;
          editingPhoneTxtController.text = editing.value!.phone;
          editingDescriptionTxtController.text =
              editing.value!.description ?? "";
          editingSelectedAmenities.value = editing.value!.amenities ?? [];
          editingHasHoliday.value = editing.value!.hasHoliday;
          editingSelectedRegularHoliday.value =
              editing.value!.regularHoliday ?? "";
          editingSelectedBusinessTimeConfig.value =
              editing.value!.businessTimeConfig;
        }
        print('파트너 정보 가져오기 성공: $partner');
      } else {
        print('파트너 정보 가져오기 실패: ${response.data}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('서버 응답 오류: ${e.response?.data}');
      } else {
        print('요청 오류: ${e.message}');
      }
    }
  }

  //유저의 파트너 가져오기(가게등록해서 등록된 가게)
  Future<List<Partner>> fetchUserPartners(int userId) async {
    try {
      final response = await _dio.get(
        '/partners/byUser',
        queryParameters: {'userId': userId},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        print("파트너 목록 가져오기 성공: $data");
        // JSON 배열을 Partner 객체 리스트로 변환
        userPartners.value = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
        return userPartners; // 파트너 목록을 반환
      } else {
        print("파트너 목록 가져오기 실패: ${response.statusCode}");
        return [];
      }
    } catch (error) {
      print("파트너 목록 가져오기 중 오류 발생: $error");
      return [];
    }
  }

  Future<void> addEditingPartner() async {
    try {
      DateTime today = DateTime.now();
      editing.value = Partner(
        id: null,
        name: editingPartnerNameTxtController.text,
        storePhotos: editingStorePhotos.map((p) => p.path).toList(),
        businessProofs: editingBusinessProofs.map((p) => p.path).toList(),
        foodType: editingSelectedFoodType.value,
        category: editingSelectedCategory.value,
        address: editingAddress.value,
        phone: editingPhoneTxtController.text,
        hasHoliday: editingHasHoliday.value,
        businessTimeConfig: editingSelectedBusinessTimeConfig.value,
        createdAt: today,
        updatedAt: today,
      );
      print("[SUCCESS] Add new partner.");
    } catch (e) {
      print("[ERROR] Fail add new partner.");
    }
  }

  Future<void> addNewPartner() async {
    try {
      DateTime today = DateTime.now();
      newPartner.value = Partner(
        id: null,
        name: partnerNameTxtController.text,
        storePhotos: storePhotos.map((p) => p.path).toList(),
        businessProofs: businessProofs.map((p) => p.path).toList(),
        foodType: selectedFoodType.value,
        category: selectedCategory.value,
        address: address.value,
        phone: phoneTxtController.text,
        hasHoliday: hasHoliday.value,
        businessTimeConfig: selectedBusinessTimeConfig.value,
        createdAt: today,
        updatedAt: today,
      );
      print("[SUCCESS] Add new partner.");
    } catch (e) {
      print("[ERROR] Fail add new partner.");
    }
  }

  void showSelectedPartner(BuildContext context, Partner partner,
      String businessStatus, double rating, String replyCount) {
    double width = MediaQuery.of(context).size.width;
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
      barrierLabel: "닫기", // 접근성 레이블 설정
      barrierColor: Colors.black54, // 배경 색상
      pageBuilder: (context, animation, secondaryAnimation) {
        return PartnerShowView(
          partner: partner,
          businessStatus: businessStatus,
          rating: rating,
          replyCount: replyCount,
        );
      },
    );
  }

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

//어떤식당을 찾으시나요
  Future<void> fetchPartnersByFoodCategory(String foodType) async {
    try {
      isLoading.value = true;
      final response = await _dio.get(
        '/partners/foodType',
        queryParameters: {'foodType': foodType},
      );

      if (response.statusCode == 200) {
        // 응답 데이터가 JSON 배열인지 확인 후 처리
        final List<dynamic> data = response.data;

        // JSON 배열을 Partner 객체 리스트로 변환
        partners.value = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
        print("[GET SUCCESS] 어떤식당을 찾으시나요 데이터 조회 성공: ${partners.value}");
      } else {
        partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
        print("[GET ERROR] 어떤식당을 찾으시나요 데이터 조회 실패: ${response.statusMessage}");
      }
    } catch (e) {
      partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
      print("[GET ERROR] 어떤식당을 찾으시나요 데이터 조회 실패: $e");
    } finally {
      isLoading.value = false; // 로딩 종료
    }
  }

//요즘이런식당이 HOT해
  Future<void> fetchPartnersByCategory(String category) async {
    try {
      isLoading.value = true;
      final response = await _dio.get(
        '/partners/category',
        queryParameters: {'category': category},
      );

      if (response.statusCode == 200) {
        // 응답 데이터가 JSON 배열인지 확인 후 처리
        final List<dynamic> data = response.data;

        // JSON 배열을 Partner 객체 리스트로 변환
        partners.value = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
        print("[GET SUCCESS] 요즘이런식당이 HOT해 데이터 조회 성공: ${partners.value}");
      } else {
        partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
        print("[GET ERROR] 요즘이런식당이 HOT해 데이터 조회 실패: ${response.statusMessage}");
      }
    } catch (e) {
      partners.value = <Partner>[]; // 에러 발생 시 빈 리스트로 초기화
      print("[GET ERROR] 요즘이런식당이 HOT해 데이터 조회 실패: $e");
    } finally {
      isLoading.value = false; // 로딩 종료
    }
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

//최근 본 매장 가져오기
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

  // 메뉴 등록 함수
  Future<void> registerMenu({
    required int partnerId,
    required String name,
    required double price,
    required String category,
    required File imageFile,
  }) async {
    try {
      final uri = Uri.parse('$baseUrl/partners/$partnerId/menus');
      final request = http.MultipartRequest('POST', uri);

      // Form 데이터 추가
      request.fields['name'] = name;
      request.fields['price'] = price.toString();
      request.fields['category'] = category;

      // 이미지 파일 추가
      final imageStream = http.ByteStream(imageFile.openRead());
      final imageLength = await imageFile.length();
      final multipartFile = http.MultipartFile(
        'image',
        imageStream,
        imageLength,
        filename: imageFile.path.split('/').last,
      );
      request.files.add(multipartFile);

      // 요청 보내기
      final response = await request.send();

      if (response.statusCode == 201) {
        print("메뉴 등록 성공");
      } else {
        final errorResponse = await http.Response.fromStream(response);
        print("메뉴 등록 실패: ${errorResponse.body}");
      }
    } catch (e) {
      print("오류 발생: $e");
    }
  }

  // 갤러리에서 이미지 선택
  Future<void> pickMenuImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // return File(pickedFile.path);
      menuImg.value = File(pickedFile.path);
    }
    // return null;
  }
}
