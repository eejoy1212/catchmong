import 'package:catchmong/model/review.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReviewController extends GetxController {
  RxList<Review> favoriteReviews = <Review>[].obs;
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
}
