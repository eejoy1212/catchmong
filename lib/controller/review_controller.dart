import 'dart:convert';
import 'dart:io';
import 'package:catchmong/const/constant.dart';
import 'package:http/http.dart' as http;
import 'package:catchmong/model/review.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewController extends GetxController {
  RxList<Review> favoriteReviews = <Review>[].obs;
  RxList<Review> myReviews = <Review>[].obs;
  RxList<Review> partnerReviews = <Review>[].obs;
  RxInt bannerIdx = 0.obs;
  RxBool isLoading = false.obs;
  List<RxBool> isExpanded = <RxBool>[].obs;
  List<RxBool> isPartnerExpanded = <RxBool>[].obs;
  Rxn<Review> editing = Rxn<Review>(null);
  final String baseUrl = 'http://$myPort:3000';
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://$myPort:3000', // API 베이스 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 제한 시간
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 제한 시간
  ));
  @override
  void onInit() {
    fetchFavoriteReviews();
    super.onInit();
  }

  String formatThousands(num number) {
    String formattedNumber = NumberFormat('#,###').format(number);
    return formattedNumber;
  }

  //인기 매장 top 10
  Future<void> fetchFavoriteReviews() async {
    try {
      // GET 요청 보내기
      final response = await _dio.get(
        '/reviews/top-rated',
      );

      // 성공적인 응답 처리
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        favoriteReviews.value = data
            .map((json) => Review.fromJson(json as Map<String, dynamic>))
            .toList();
        print('[GET SUCCESS]인기 리뷰 : $favoriteReviews');
      } else {
        throw Exception('[GET ERROR]인기 리뷰 에러:  ${response.statusCode}');
      }
    } catch (e) {
      print('[GET ERROR]인기 리뷰 에러: $e');
      throw Exception('[GET ERROR]인기 리뷰 에러: $e');
    }
  }

  //내 리뷰 조회
  Future<void> fetchMyReviews(int userId) async {
    try {
      isLoading.value = true;
      // GET 요청 보내기
      final response = await _dio.get('/reviews/$userId');

      if (response.statusCode == 200) {
        // 응답 데이터를 List<Review>로 변환
        final List<dynamic> data = response.data;
        myReviews.value =
            data.map((review) => Review.fromJson(review)).toList();
        isExpanded = List.generate(myReviews.length, (index) => false.obs);
        print('[GET SUCCESS]내 리뷰 : $myReviews');
      } else {
        print('[GET ERROR]내 리뷰 에러: ${response.statusCode}');
        throw Exception('Failed to fetch reviews: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('[DIO ERROR]DioError: ${e.response?.statusCode} - ${e.message}');
      throw Exception(
          '[DIO ERROR]DioError: ${e.response?.statusCode} - ${e.message}');
    } catch (e) {
      print('[GET ERROR]내 리뷰 에러: $e');
      throw Exception('[GET ERROR]내 리뷰 에러: $e');
    } finally {
      isLoading.value = false;
    }
  }

//내 리뷰 조회
  Future<void> fetchPartnerReviews(int partnerId) async {
    try {
      isLoading.value = true;
      // GET 요청 보내기
      final response = await _dio.get('/reviews/partner/$partnerId');

      if (response.statusCode == 200) {
        // 응답 데이터를 List<Review>로 변환
        final List<dynamic> data = response.data;
        partnerReviews.value =
            data.map((review) => Review.fromJson(review)).toList();
        // isPartnerExpanded =
        //     List.generate(partnerReviews.length, (index) => false.obs);
        print('[GET SUCCESS]마이페이지 내 가게 리뷰 : $partnerReviews');
      } else {
        print('[GET ERROR]마이페이지 내 가게 리뷰 에러: ${response.statusCode}');
        throw Exception('Failed to fetch reviews: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('[DIO ERROR]DioError: ${e.response?.statusCode} - ${e.message}');
      throw Exception(
          '[DIO ERROR]DioError: ${e.response?.statusCode} - ${e.message}');
    } catch (e) {
      print('[GET ERROR]내 리뷰 에러: $e');
      throw Exception('[GET ERROR]내 리뷰 에러: $e');
    } finally {
      isLoading.value = false;
    }
  }

//내 리뷰 삭제
  Future<bool> deleteMyReviews(
      {required int reviewId, required int userId}) async {
    try {
      final response = await _dio.delete(
        '/reviews/delete',
        queryParameters: {
          'reviewId': reviewId,
          'userId': userId,
        },
      );

      if (response.statusCode == 200) {
        print("[DELETE SUCCESS]내 리뷰 삭제 성공: ${response.statusCode}");
        myReviews.removeWhere((review) => review.id == reviewId);
        return true; // 삭제 성공
      } else {
        print("[DELETE ERROR]내 리뷰 삭제 에러: ${response.data}");
        return false; // 삭제 실패
      }
    } on DioError catch (e) {
      print("[DELETE ERROR]내 리뷰 삭제 에러: ${e.response?.data}");
      return false; // 에러 발생
    } catch (e) {
      print("[DELETE ERROR]내 리뷰 삭제 에러: $e");
      return false; // 예기치 못한 에러
    }
  }

//후기 수정
  Future<void> updateReview({
    required int reviewId,
    required int userId,
    double? rating,
    String? content,
  }) async {
    final String url = '$baseUrl/reviews/update';

    try {
      // 요청 데이터 생성
      final Map<String, dynamic> data = {
        'reviewId': reviewId,
        'userId': userId,
        if (rating != null) 'rating': rating,
        if (content != null) 'content': content,
      };

      // API 호출
      final response = await _dio.put(url, data: data);

      if (response.statusCode == 200) {
        print("[PUT SUCCESS] 내 리뷰 수정 성공: ${response.data}");
        final data = response.data;
        int nowIdx =
            myReviews.indexWhere((review) => review.id == editing.value!.id);
        myReviews[nowIdx] = editing.value!;
        Get.back();
      } else {
        print(
            "[PUT ERROR] 내 리뷰 수정 실패: ${response.statusCode} - ${response.data}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(
            "[PUT ERROR] 서버 응답 에러: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("[PUT ERROR] 요청 중 에러 발생: $e");
      }
    }
  }
}
