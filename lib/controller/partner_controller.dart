import 'package:catchmong/model/partner.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class Partner2Controller extends GetxController {
  var partners = <Partner>[].obs; // RxList<Partner>
  var isLoading = false.obs; // 로딩 상태
  RxInt currentResPage = 0.obs; // 현재 페이지
  RxInt currentHotPage = 0.obs; // 현재 페이지
  RxString searchKeyword = ''.obs; // 검색어 상태 변수
  String baseUrl = 'http://192.168.200.102:3000'; // API 베이스 URL
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.200.102:3000', // API 베이스 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 제한 시간
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 제한 시간
  ));

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
        print("파트너 dynamic 데이터 조회: $data");

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
