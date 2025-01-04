import 'package:catchmong/model/review.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewController extends GetxController {
  RxList<Review> favoriteReviews = <Review>[].obs;
  RxList<Review> myReviews = <Review>[].obs;
  RxBool isLoading = false.obs;
  List<RxBool> isExpanded = <RxBool>[].obs;
  final String baseUrl = 'http://192.168.200.102:3000';
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://192.168.200.102:3000', // API 베이스 URL
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
}
