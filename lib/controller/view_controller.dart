import 'package:catchmong/const/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewController extends GetxController {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://$myPort:3000/views', // API 베이스 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 제한 시간
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 제한 시간
  ));
  List<String> datepickType = [
    "년간",
    "월간",
    "주간",
    "일간",
    "직접선택",
  ];
  RxString selectedDatePickType = "일간".obs;

  List<Rx<DateTime>> selectedDate = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .obs, // 오늘 자정 (00:00:00)
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23,
            59, 59)
        .obs, // 오늘의 마지막 시간 (23:59:59)
  ];
  RxMap<String, int> weekStats = RxMap();
  RxMap<String, dynamic> userStats = RxMap();
  RxList<bool> isOnline = [true, false].obs;
  RxList<List<int>> ageGroupStats = RxList.filled(7, [0, 0]);
  Future<void> selectStatisticsDate(BuildContext context) async {
    DateTime now = DateTime.now();

    // 선택 방식에 따라 날짜 선택 형태 결정
    switch (selectedDatePickType.value) {
      case "년간":
        // 년도 선택 (Custom Dialog 사용)
        final int? pickedYear = await showDialog<int>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("년도 선택"),
              content: SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: 10, // 최근 10년
                  itemBuilder: (context, index) {
                    final year = now.year - index;
                    return ListTile(
                      title: Text(year.toString()),
                      onTap: () {
                        Navigator.of(context).pop(year);
                      },
                    );
                  },
                ),
              ),
            );
          },
        );

        if (pickedYear != null) {
          // 선택된 연도를 반영
          selectedDate[0].value = DateTime(pickedYear, 1, 1);
          selectedDate[1].value =
              DateTime(pickedYear, 12, 31, 23, 59, 59); // 연말 마지막 시간
        }
        break;

      case "월간":
        // 월 선택
        final DateTime initialDate = DateTime(now.year, now.month, 1);

        final DateTime? pickedMonth = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime(2000, 1),
          lastDate: DateTime(2100, 12),
          selectableDayPredicate: (date) {
            return date.day == 1; // 월의 첫 번째 날만 선택 가능
          },
        );

        if (pickedMonth != null) {
          // 선택된 월의 시작과 끝 설정
          selectedDate[0].value =
              DateTime(pickedMonth.year, pickedMonth.month, 1);
          selectedDate[1].value = DateTime(
            pickedMonth.year,
            pickedMonth.month + 1,
            0,
            23,
            59,
            59,
          ); // 월의 마지막 날 마지막 시간
        }
        break;

      case "주간":
        // 주 선택
        final DateTime? pickedWeek = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedWeek != null) {
          // 주의 시작 (월요일)과 끝 (일요일) 계산
          int weekday = pickedWeek.weekday;
          selectedDate[0].value =
              pickedWeek.subtract(Duration(days: weekday - 1)); // 월요일
          selectedDate[1].value = pickedWeek
              .add(Duration(days: 7 - weekday))
              .add(Duration(hours: 23, minutes: 59, seconds: 59)); // 일요일 마지막 시간
        }
        break;

      case "일간":
        // 기본 날짜 선택
        final DateTime? pickedDay = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedDay != null) {
          // 선택된 날짜 설정
          selectedDate[0].value =
              DateTime(pickedDay.year, pickedDay.month, pickedDay.day);
          selectedDate[1].value = DateTime(
            pickedDay.year,
            pickedDay.month,
            pickedDay.day,
            23,
            59,
            59,
          ); // 하루의 마지막 시간
        }
        break;

      case "직접선택":
        // 날짜 범위 선택 (RangePicker)
        final DateTimeRange? pickedRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedRange != null) {
          // 범위 시작과 끝 설정
          selectedDate[0].value = pickedRange.start;
          selectedDate[1].value = DateTime(
            pickedRange.end.year,
            pickedRange.end.month,
            pickedRange.end.day,
            23,
            59,
            59,
          ); // 범위 끝의 마지막 시간
        }
        break;

      default:
        // 기본 동작
        break;
    }
  }

  /// 📌 **특정 파트너의 조회수를 생성하는 함수**
  Future<bool> createPostView(
      {required int partnerId, required int userId}) async {
    try {
      final response = await _dio.post('/', data: {
        "partnerId": partnerId,
        "userId": userId,
      });

      if (response.statusCode == 201) {
        print("✅ 조회수 생성 성공: ${response.data}");
        return true;
      } else {
        print("❌ 조회수 생성 실패: ${response.data}");
        return false;
      }
    } catch (e) {
      print("⚠️ 조회수 생성 중 오류 발생: $e");
      return false;
    }
  }

  Future<bool> fetchWeekdayStats({
    required int partnerId,
  }) async {
    try {
      final response = await _dio.get(
        '/weekday-stats',
        queryParameters: {
          "partnerId": partnerId,
          "startDate": selectedDate[0].value.toUtc().toIso8601String(),
          "endDate": selectedDate[1].value.toUtc().toIso8601String(),
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final stats = Map<String, int>.from(data['stats']);
        print("요일별 조회수: $stats");
        weekStats.value = stats;
        return true;
      } else {
        print("Error fetching weekday stats: ${response.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      print("DioError: ${e.message}");
      if (e.response != null) {
        print("Response: ${e.response?.data}");
      }
      return false;
    }
  }

  Future<bool> getUserDemographics({
    required int partnerId,
  }) async {
    try {
      final response = await _dio.get(
        '/user-demographics',
        queryParameters: {
          "partnerId": partnerId,
          'startDate': selectedDate[0].value.toUtc().toIso8601String(),
          'endDate': selectedDate[1].value.toUtc().toIso8601String(),
          'isOnline': isOnline[0].toString(), // true 또는 false를 문자열로 변환
        },
      );

      if (response.statusCode == 200) {
        userStats.value = response.data;
        print("성별 & 연령 통계>>>$userStats");
        Map group = userStats["ageGroupStats"];
        if (group.isNotEmpty) {
          ageGroupStats.value = [
            [
              userStats["ageGroupStats"]["TEN"]["MAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["TEN"]["MAN"]) ??
                          0.0)
                      .round(),
              userStats["ageGroupStats"]["TEN"]["WOMAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["TEN"]["WOMAN"]) ??
                          0.0)
                      .round(),
            ],
            [
              userStats["ageGroupStats"]["TWENTY"]["MAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["TWENTY"]["MAN"]) ??
                          0.0)
                      .round(),
              userStats["ageGroupStats"]["TWENTY"]["WOMAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["TWENTY"]["WOMAN"]) ??
                          0.0)
                      .round(),
            ],
            [
              userStats["ageGroupStats"]["THIRTY"]["MAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["THIRTY"]["MAN"]) ??
                          0.0)
                      .round(),
              userStats["ageGroupStats"]["THIRTY"]["WOMAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["THIRTY"]["WOMAN"]) ??
                          0.0)
                      .round(),
            ],
            [
              userStats["ageGroupStats"]["FORTY"]["MAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["FORTY"]["MAN"]) ??
                          0.0)
                      .round(),
              userStats["ageGroupStats"]["FORTY"]["WOMAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["FORTY"]["WOMAN"]) ??
                          0.0)
                      .round(),
            ],
            [
              userStats["ageGroupStats"]["FIFTY"]["MAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["FIFTY"]["MAN"]) ??
                          0.0)
                      .round(),
              userStats["ageGroupStats"]["FIFTY"]["WOMAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["FIFTY"]["WOMAN"]) ??
                          0.0)
                      .round(),
            ],
            [
              userStats["ageGroupStats"]["SIXTY"]["MAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["SIXTY"]["MAN"]) ??
                          0.0)
                      .round(),
              userStats["ageGroupStats"]["SIXTY"]["WOMAN"] == null
                  ? 0
                  : (double.tryParse(
                              userStats["ageGroupStats"]["SIXTY"]["WOMAN"]) ??
                          0.0)
                      .round(),
            ],
            [
              userStats["ageGroupStats"]["SEVENTY_PLUS"]["MAN"] == null
                  ? 0
                  : (double.tryParse(userStats["ageGroupStats"]["SEVENTY_PLUS"]
                              ["MAN"]) ??
                          0.0)
                      .round(),
              userStats["ageGroupStats"]["SEVENTY_PLUS"]["WOMAN"] == null
                  ? 0
                  : (double.tryParse(userStats["ageGroupStats"]["SEVENTY_PLUS"]
                              ["WOMAN"]) ??
                          0.0)
                      .round(),
            ],
          ];
          ageGroupStats.refresh();
        } else {
          ageGroupStats.value = RxList.filled(7, [0, 0]);
        }

        return true;
      } else {
        print("Failed to fetch user demographics: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      print("Error fetching user demographics: $error");
      return false;
    }
  }
}
