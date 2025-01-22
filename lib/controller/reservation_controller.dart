import 'package:catchmong/const/constant.dart';
import 'package:catchmong/model/reservation.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReservationConteroller extends GetxController {
  RxList<Reservation> reservations = RxList.empty();
  RxInt sortType = 0.obs;
  List<String> datepickType = [
    "년간",
    "월간",
    "주간",
    "일간",
    "직접선택",
  ];
  RxString selectedDatePickType = "일간".obs;

  List<Rx<DateTime>> selectedDate = [DateTime.now().obs, DateTime.now().obs];

  String baseUrl = 'http://$myPort:3000/reservations'; // API 베이스 URL
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://$myPort:3000/reservations', // API 베이스 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 제한 시간
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 제한 시간
  ));
  RxString selectedResDatePickType = "일간".obs;
  List<String> dateItems = [
    "년간",
    "월간",
    "주간",
    "일간",
    "직접선택",
  ];
  RxString selectedDateItem = "직접선택".obs;
  List<Rx<DateTime>> selectedResDate = [DateTime.now().obs, DateTime.now().obs];
  RxList<Reservation> myReservations = RxList.empty();
  String getSortType() {
    switch (sortType.value) {
      case 0:
        return "ALL";
      case 1:
        return "PENDING";
      case 2:
        return "CONFIRM";
      case 3:
        return "COMPLETED";
      case 4:
        return "CANCELLED";
      default:
        return "";
    }
  }

  Future<void> fetchReservations(int userId) async {
    try {
      // GET 요청 보내기
      final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss'); // 원하는 포맷
      final List<String> reservationDateSerialized =
          selectedDate.map((date) => formatter.format(date.value)).toList();
      final response = await _dio.get(
        baseUrl,
        queryParameters: {
          'userId': userId,
          "sortType": getSortType(),
          "startDate": reservationDateSerialized[0],
          "endDate": reservationDateSerialized[1],
        }, // 쿼리 파라미터
      );

      if (response.statusCode == 200) {
        // final res= response.data; // 예약 데이터 리스트 반환
        final List<dynamic> data = response.data;

        // JSON 배열을 Partner 객체 리스트로 변환
        reservations.value = data
            .map((json) => Reservation.fromJson(json as Map<String, dynamic>))
            .toList();
        print("예약 데이터 ${reservations.value}");
      } else {
        reservations.value = [];
        print("[FAIL] 예약 데이터 불러오기 실패");
        // throw Exception('Failed to fetch reservations');
      }
    } catch (e) {
      reservations.value = [];
      print("[FAIL] 예약 데이터 불러오기 실패");
      // throw Exception('Error fetching reservations: $e');
    }
  }

  String formatReservationDate(List<DateTime> reservationDate) {
    // 입력 검증: 날짜 리스트가 비어 있거나 길이가 2가 아닌 경우 예외 처리
    if (reservationDate.isEmpty || reservationDate.length != 2) {
      return '날짜 정보가 올바르지 않습니다.';
    }

    // 시작 시간과 종료 시간 가져오기
    DateTime start = reservationDate[0];
    DateTime end = reservationDate[1];

    // 요일 계산
    String weekday = DateFormat('EEEE').format(start);

    // 한글 요일로 변환
    weekday = weekday
        .replaceAll('Monday', '월요일')
        .replaceAll('Tuesday', '화요일')
        .replaceAll('Wednesday', '수요일')
        .replaceAll('Thursday', '목요일')
        .replaceAll('Friday', '금요일')
        .replaceAll('Saturday', '토요일')
        .replaceAll('Sunday', '일요일');

    // 주말/평일 구분
    bool isWeekend = start.weekday == 6 || start.weekday == 7;
    String reservationType = isWeekend ? '주말 예약' : '평일 예약';

    // 시간 포맷
    String startTime = DateFormat('H시mm분').format(start);
    String endTime = DateFormat('H시mm분').format(end);

    // 최종 문자열 생성
    return '$reservationType($startTime~$endTime)';
  }

  Future<void> selectDate(BuildContext context) async {
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
          selectedDate[0].value = DateTime(pickedYear);
          selectedDate[1].value = DateTime(pickedYear, 12, 31);
        }
        break;

      case "월간":
        // 월 선택
        final DateTime now = DateTime.now();
        // initialDate를 항상 현재 월의 첫 번째 날로 설정
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
          selectedDate[1].value =
              DateTime(pickedMonth.year, pickedMonth.month + 1, 0);
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
              pickedWeek.subtract(Duration(days: weekday - 1));
          selectedDate[1].value = pickedWeek.add(Duration(days: 7 - weekday));
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
          selectedDate[0].value = pickedDay;
          selectedDate[1].value = pickedDay;
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
          selectedDate[1].value = pickedRange.end;
        }
        break;

      default:
        // 기본 동작
        break;
    }
  }

  String formatReservationTime(DateTime now) {
    // 날짜 부분 포맷팅
    String date = DateFormat('yyyy.MM.dd').format(now);

    // 시간 부분 포맷팅
    String time = DateFormat('a h:mm').format(now);

    // `a`를 한글로 변환 (오전/오후)
    time = time.replaceAll('AM', '오전').replaceAll('PM', '오후');

    // 최종 포맷
    String formattedDateTime = '$date | $time';
    return formattedDateTime;
  }

  String formatDateRange(List<Rx<DateTime>> dateRange) {
    final dateFormatter = DateFormat('yyyy.MM.dd');
    return '${dateFormatter.format(dateRange[0].value)}~${dateFormatter.format(dateRange[1].value)}';
  }

  Future<void> selectReservationDate(BuildContext context) async {
    DateTime now = DateTime.now();

    // 선택 방식에 따라 날짜 선택 형태 결정
    switch (selectedDateItem.value) {
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
          selectedResDate[0].value = DateTime(pickedYear);
          selectedResDate[1].value = DateTime(pickedYear, 12, 31);
        }
        break;

      case "월간":
        // 월 선택
        final DateTime? pickedMonth = await showDatePicker(
          context: context,
          initialDate: now,
          firstDate: DateTime(2000, 1),
          lastDate: DateTime(2100, 12),
          selectableDayPredicate: (date) {
            return date.day == 1; // 월의 첫 번째 날만 선택 가능
          },
        );

        if (pickedMonth != null) {
          // 선택된 월의 시작과 끝 설정
          selectedResDate[0].value =
              DateTime(pickedMonth.year, pickedMonth.month);
          selectedResDate[1].value =
              DateTime(pickedMonth.year, pickedMonth.month + 1, 0);
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
          selectedResDate[0].value =
              pickedWeek.subtract(Duration(days: weekday - 1));
          selectedResDate[1].value =
              pickedWeek.add(Duration(days: 7 - weekday));
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
          selectedResDate[0].value = pickedDay;
          selectedResDate[1].value = pickedDay;
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
          selectedResDate[0].value = pickedRange.start;
          selectedResDate[1].value = pickedRange.end;
        }
        break;

      default:
        // 기본 동작
        break;
    }
  }

  Future<void> fetchPartnerReservations({
    // required int userId,
    required int partnerId,
  }) async {
    try {
      final DateFormat formatter = DateFormat('yyyy-MM-dd'); // 원하는 포맷
      String startDate = formatter.format(selectedResDate[0].value);
      String endDate = selectedResDate[1].value.toUtc().toIso8601String();
      final response = await _dio.get(
        baseUrl + "/partner",
        queryParameters: {
          // 'userId': userId,
          'partnerId': partnerId,
          'startDate': startDate,
          'endDate': endDate,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data; // 예약 데이터 리스트 반환

        myReservations.value = data
            .map((json) => Reservation.fromJson(json as Map<String, dynamic>))
            .toList();
        print("예약 데이터 ${myReservations.value}");
      } else if (response.statusCode == 404) {
        myReservations.value = [];
      } else {
        throw Exception('Failed to fetch partner reservations');
      }
    } catch (e) {
      throw Exception('Error fetching partner reservations: $e');
    }
  }
}
