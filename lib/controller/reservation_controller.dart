import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/model/reservation.dart';
import 'package:catchmong/model/reservation_setting.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ReservationConteroller extends GetxController {
  //예약 설정
  RxList<ReservationSetting> reservationSettings = RxList.empty();
  RxList<bool> reservationSettingEditModes = RxList.empty();
  RxBool isSetting = false.obs;
  final TextEditingController reservationNameController =
      TextEditingController();
  final TextEditingController reservationDescriptionController =
      TextEditingController();
  // List<String> dayTypeOptions = ["평일", "주말"];
  RxString selectedDayType = "평일".obs;
  RxString selectedEditDayType = "평일".obs;
  RxString selectedMinuteType = "30분".obs;
  RxString selectedEditMinuteType = "30분".obs;
  Rx<DateTime> selectedStartTime = DateTime.now().obs;
  Rx<DateTime> selectedEndTime = DateTime.now().obs;
  Rx<DateTime> selectedEditStartTime = DateTime.now().obs;
  Rx<DateTime> selectedEditEndTime = DateTime.now().obs;
  RxList<String> selectedNumOfPeople = RxList.empty();
  RxList<String> selectedEditNumOfPeople = RxList.empty();
  final TextEditingController tableNumTxtController = TextEditingController();
  Rxn<File> selectedSettingImage = Rxn<File>();
  Rxn<File> selectedEditSettingImage = Rxn<File>();
  //예약 설정
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

  List<Rx<DateTime>> selectedDate = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .obs, // 오늘 자정 (00:00:00)
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23,
            59, 59)
        .obs, // 오늘의 마지막 시간 (23:59:59)
  ];

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
  List<Rx<DateTime>> selectedResDate = [
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
        .obs, // 오늘 자정 (00:00:00)
    DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23,
            59, 59)
        .obs, // 오늘의 마지막 시간 (23:59:59)
  ];

  RxList<Reservation> myReservations = RxList.empty();
  Rx<DateTime> selectedReservationDate = DateTime.now().obs;
  RxInt selectedReservationTimeIdx = 0.obs;
  RxInt selectedReservationNumOfPeopleIdx = 0.obs;
  final TextEditingController reservationReqController =
      TextEditingController();
  RxBool agreePrivacy = false.obs;
  RxList<DateTime> fullyDt = RxList.empty();
  RxString cancelReason = "개인 사정으로 방문이 어렵습니다.".obs;
  RxInt reasonIdx = 0.obs;
  //점주측 취소 창
  RxInt ceoReasonIdx = 0.obs;
  RxString ceoCancelReason = "임시 휴업/영업 시간 변경".obs;
  //점주측 취소 창
  String getSortType() {
    switch (sortType.value) {
      case 0:
        return "ALL";
      case 1:
        return "PENDING";
      case 2:
        return "CONFIRMED";
      case 3:
        return "COMPLETED";
      case 4:
        return "CANCELLED";
      default:
        return "";
    }
  }

  String formatReservationPeriod(DateTime startDate, DateTime endDate) {
    // 요일 확인 (1: 월요일 ~ 5: 금요일 -> 평일, 6: 토요일, 7: 일요일 -> 주말)
    bool isWeekend(DateTime date) {
      return date.weekday == 6 || date.weekday == 7;
    }

    // 시간 포맷: HH시 mm분
    String formatTime(DateTime date) {
      return "${date.hour.toString().padLeft(2, '0')}시 ${date.minute.toString().padLeft(2, '0')}분";
    }

    // 시작 시간과 종료 시간 포맷
    String startTime = formatTime(startDate);
    String endTime = formatTime(endDate);

    // 평일 또는 주말 판단
    String dayType = isWeekend(startDate) ? "주말 예약" : "평일 예약";

    // 결과 반환
    return "$dayType($startTime~$endTime)";
  }

  List<DateTime> getTimeSlots(DateTime start, DateTime end, String timeUnit) {
    List<DateTime> slots = [];
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      slots.add(current);
      current = current
          .add(Duration(minutes: timeUnit == "THIRTY_MIN" ? 30 : 60)); // 30분 추가
    }
    return slots;
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

  Future<void> postCreateReservationSetting({
    // required int partnerId,
    // required String name,
    // String? description,
    // required String availabilityType, // WEEKDAY, WEEKEND, DAILY 중 하나
    // required String startTime, // HH:mm:ss 형식
    // required String endTime, // HH:mm:ss 형식
    // required String timeUnit, // THIRTY_MIN 또는 ONE_HOUR
    // required int availableTables,
    // required List<String> allowedPeople,
    required ReservationSetting reservationSetting,
    // required File reservationImage, // 이미지 파일
  }) async {
    final uri =
        Uri.parse('http://$myPort:3000/reservationsetting'); // 서버 URL로 변경
    final request = http.MultipartRequest('POST', uri);

    // 필드 추가
    request.fields['partnerId'] = reservationSetting.partnerId.toString();
    request.fields['name'] = reservationSetting.name;
    if (reservationSetting.description != null) {
      request.fields['description'] = reservationSetting.description ?? "";
    }
    request.fields['availabilityType'] = reservationSetting.availabilityType;
    request.fields['startTime'] =
        reservationSetting.startTime.toIso8601String();
    request.fields['endTime'] = reservationSetting.endTime.toIso8601String();
    request.fields['timeUnit'] = reservationSetting.timeUnit;
    request.fields['availableTables'] =
        reservationSetting.availableTables.toString();
    request.fields['allowedPeople'] = reservationSetting.allowedPeople;

    // 이미지 파일 추가
    if (selectedSettingImage.value != null) {
      request.files.add(await http.MultipartFile.fromPath(
        'reservationImage',
        selectedSettingImage.value!.path,
      ));
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        final responseBody = await response.stream.bytesToString();
        final responseData = jsonDecode(responseBody);
        print('Reservation setting created: $responseData');
        reservationSettings.value = [
          ReservationSetting.fromJson(responseData),
          ...reservationSettings
        ];
      } else {
        final errorBody = await response.stream.bytesToString();
        print('Failed to create reservation setting: $errorBody');
      }
    } catch (e) {
      print('Error: $e');
    }
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

    switch (selectedDateItem.value) {
      case "년간":
        // 년도 선택
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
          selectedResDate[0].value = DateTime(pickedYear);
          selectedResDate[1].value =
              DateTime(pickedYear, 12, 31, 23, 59, 59); // 연말의 마지막 시간 설정
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
          selectedResDate[0].value =
              DateTime(pickedMonth.year, pickedMonth.month);
          selectedResDate[1].value = DateTime(
            pickedMonth.year,
            pickedMonth.month + 1,
            0,
            23,
            59,
            59,
          ); // 월의 마지막 날 마지막 시간 설정
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
          int weekday = pickedWeek.weekday;
          selectedResDate[0].value =
              pickedWeek.subtract(Duration(days: weekday - 1));
          selectedResDate[1].value =
              pickedWeek.add(Duration(days: 7 - weekday)).subtract(
                    Duration(seconds: 1),
                  ); // 일요일 마지막 시간 설정
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
          selectedResDate[0].value = pickedDay;
          selectedResDate[1].value = DateTime(pickedDay.year, pickedDay.month,
              pickedDay.day, 23, 59, 59); // 하루의 마지막 시간 설정
        }
        break;

      case "직접선택":
        // 날짜 범위 선택
        final DateTimeRange? pickedRange = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );

        if (pickedRange != null) {
          selectedResDate[0].value = pickedRange.start;
          selectedResDate[1].value = DateTime(
            pickedRange.end.year,
            pickedRange.end.month,
            pickedRange.end.day,
            23,
            59,
            59,
          ); // 범위 끝의 마지막 시간 설정
        }
        break;

      default:
        break;
    }
  }

  Future<void> fetchPartnerReservations({
    // required int userId,
    required int partnerId,
  }) async {
    try {
      String startDate = selectedResDate[0].value.toIso8601String();
      String endDate = selectedResDate[1].value.toIso8601String();
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

  Future<void> fetchReservationSettings(int partnerId) async {
    try {
      final response =
          await _dio.get("http://$myPort:3000/reservationsetting/$partnerId");

      if (response.statusCode == 200) {
        // JSON 데이터를 리스트로 변환
        final List<dynamic> jsonData = response.data;
        final List<Map<String, dynamic>> originReservationSettings =
            jsonData.map((data) => data as Map<String, dynamic>).toList();
        List<ReservationSetting> origin = originReservationSettings
            .map((json) => ReservationSetting.fromJson(json))
            .toList();
        reservationSettings.value = origin.reversed.toList();
        reservationSettingEditModes.value =
            List.generate(reservationSettings.length, (int index) => false);
        // 콘솔에 출력
        // print('Reservation Settings for Partner ID $partnerId:');
        // for (var setting in reservationSettings) {
        //   print(setting);
        // }
      } else if (response.statusCode == 404) {
        print('No reservation settings found for Partner ID: $partnerId');
      } else {
        print('Failed to fetch reservation settings: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching reservation settings: $e');
    }
  }

  Future<void> pickPartnerRervationDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? pickedDay = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDay != null) {
      // 선택된 날짜 설정
      selectedReservationDate.value = pickedDay;
      // selectedDate[0].value = pickedDay;
      // selectedDate[1].value = pickedDay;
    }
  }

  Future<bool> postCreateReservation({
    required int userId,
    required int partnerId,
    required int settingId,
    required DateTime reservationStartDate,
    required DateTime reservationEndDate,
    required int numOfPeople,
    String? request,
  }) async {
    try {
      // 요청 데이터
      final Map<String, dynamic> requestBody = {
        'userId': userId,
        'partnerId': partnerId,
        'settingId': settingId,
        'reservationStartDate': reservationStartDate.toUtc().toIso8601String(),
        'reservationEndDate': reservationEndDate.toUtc().toIso8601String(),
        'numOfPeople': numOfPeople,
        'request': request,
      };

      // POST 요청
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(requestBody),
      );

      // 응답 처리
      if (response.statusCode == 201) {
        print('예약 등록 성공: ${response.body}');
        return true;
      } else {
        print('예약 등록 실패: ${response.body}');
        return false;
      }
    } catch (e) {
      // 에러 처리
      print('예약 등록 중 에러 발생: $e');
      return false;
    }
  }

  Future<void> fetchFullyBookedTimes({required int settingId}) async {
    try {
      // GET 요청 보내기
      final String formattedDate =
          selectedReservationDate.value.toIso8601String();
      final response = await http.get(
        Uri.parse(
            '$baseUrl/fully-booked?selectedDate=${formattedDate}&settingId=$settingId'),
      );

      // 응답 상태 확인
      if (response.statusCode == 200) {
        // 응답 데이터 파싱
        final List<dynamic> responseData = jsonDecode(response.body);

        // String 형태의 날짜 데이터를 DateTime으로 변환
        final List<DateTime> fullyBookedTimes = responseData
            .map((timeString) => DateTime.parse(timeString as String))
            .toList();
        print('예약 꽉찬거 가져오기 성공: ${fullyBookedTimes}');
        fullyDt.value = fullyBookedTimes;
      } else {
        print('예약 데이터 가져오기 실패: ${response.body}');
      }
    } catch (e) {
      print('예약 데이터 가져오는 중 오류 발생: $e');
    }
  }

  /// 예약 취소 함수
  Future<Reservation?> patchCancelReservation({
    required int reservationId,
  }) async {
    if (ceoCancelReason.value.isEmpty) {
      print('취소 사유가 비어 있습니다.');
      return null;
    }

    try {
      final response = await _dio.patch(
        '/$reservationId/cancel',
        data: {
          'cancelReason': ceoCancelReason.value,
        },
      );

      if (response.statusCode == 200) {
        print('예약 취소 성공: ${response.data}');
        final json = response.data;
        if (json["reservation"] != null) {
          final reservation = Reservation.fromJson(json["reservation"]);
          // reservations.removeWhere((el) => el.id == reservationId);
          // reservations.add(reservation);
          // reservations.refresh(); // RxList 업데이트 호출
          return reservation;
        } else {
          print('예약 데이터가 응답에 포함되지 않았습니다.');
          return null;
        }
      } else {
        print('예약 취소 실패: ${response.statusCode} ${response.data}');
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('API 오류: ${e.response?.statusCode}');
        print('응답 데이터: ${e.response?.data}');
        return null;
      } else {
        print('네트워크 오류: ${e.message}');
        return null;
      }
    } catch (e) {
      print('알 수 없는 오류: $e');
      return null;
    }
  }

  /// 예약 확정 함수
  Future<Reservation?> patchConfirmReservation(int reservationId) async {
    try {
      final response = await _dio.patch(
        '/$reservationId/confirm',
      );

      if (response.statusCode == 200) {
        print('예약 확정 성공: ${response.data}');
        // 응답에서 업데이트된 예약 데이터를 가져오기
        final updatedReservation =
            Reservation.fromJson(response.data['reservation']);
        return updatedReservation;
        // // 예제: 컨트롤러의 예약 리스트를 업데이트하는 코드
        // controller.myReservations[controller.myReservations.indexWhere((el) => el.id == reservationId)] =
        //     updatedReservation;
        // controller.myReservations.refresh();
      } else {
        print('예약 확정 실패: ${response.statusCode} ${response.data}');
        return null;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('API 오류: ${e.response?.statusCode} ${e.response?.data}');
        return null;
      } else {
        print('네트워크 오류: ${e.message}');
        return null;
      }
    } catch (e) {
      print('알 수 없는 오류: $e');
      return null;
    }
  }
}
