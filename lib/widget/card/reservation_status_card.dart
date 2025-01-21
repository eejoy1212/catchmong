import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/model/reservation.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

enum ReservationStatus {
  completed,
  cancelled,
  waiting,
  confirmed,
}

class ReservationStatusCard extends StatelessWidget {
  final double width;
  // final ReservationStatus status;
  final Reservation reservation;
  const ReservationStatusCard(
      {super.key, required this.width, required this.reservation
      // required this.status,
      });

  String getStatusText() {
    String status = reservation.status;
    switch (status) {
      case "PENDING":
        return "예약대기";
      case "CONFIRMED":
        return "예약확정";
      case "COMPLETED":
        return "이용완료";
      default:
        return "예약취소";
    }
  }

  Color getStatusColor() {
    String status = reservation.status;
    switch (status) {
      case "PENDING":
        return CatchmongColors.red;
      case "CONFIRMED":
        return CatchmongColors.blue2;
      default:
        return CatchmongColors.gray_800;
    }
  }

  @override
  Widget build(BuildContext context) {
    String imgPath = reservation.partner.storePhotos == null
        ? ""
        : reservation.partner.storePhotos![0];
    String formatCreatedAt(DateTime dateTime) {
      // 날짜 포맷 (예: 2024.11.25)
      String formattedDate = DateFormat('yyyy.MM.dd').format(dateTime);

      // 시간 포맷 (예: 오후 5:30)
      String formattedTime = DateFormat('a h:mm', 'ko_KR').format(dateTime);

      return '$formattedDate | $formattedTime';
    }

    String formatReservationTimeWithWeekday(List<DateTime> dateTimes) {
      // 예외 처리: 리스트가 비어있거나 요소가 없을 때
      if (dateTimes.isEmpty || dateTimes.length < 2) {
        throw Exception('시작 시간과 종료 시간이 포함된 리스트를 제공해야 합니다.');
      }

      // 날짜 및 시간 포맷터
      final dateFormatter = DateFormat('yyyy.MM.dd'); // 날짜 포맷
      final timeFormatter = DateFormat('HH:mm'); // 시간 포맷

      // 시작 시간과 종료 시간 가져오기
      final startDateTime = dateTimes[0];
      final endDateTime = dateTimes[1];

      // 평일/주말 판별
      bool isWeekend = startDateTime.weekday == DateTime.saturday ||
          startDateTime.weekday == DateTime.sunday;
      String weekdayLabel = isWeekend ? "주말" : "평일";

      // 날짜와 시간 포맷
      final startDate = dateFormatter.format(startDateTime); // 예: 2024.01.12
      final startTime = timeFormatter.format(startDateTime); // 예: 11:30
      final endTime = timeFormatter.format(endDateTime); // 예: 20:40

      // 결과 포맷
      return '$weekdayLabel 예약 ($startTime ~ $endTime)';
    }

    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        top: 16,
        right: 20,
        bottom: 32,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: CatchmongColors.gray50,
      ))),
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getStatusText(),
            style: TextStyle(
              color: getStatusColor(),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //이미지
              Expanded(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: CatchmongColors.gray,
                      width: 1,
                    ), // 외부 테두리
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // 이미지를 둥글게 자르기
                    child: ImgCard(path: "http://$myPort:3000/$imgPath"),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatCreatedAt(reservation.createdAt),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: CatchmongColors.gray_800,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "",
                    // formatReservationTimeWithWeekday(
                    //     reservation.reservationDate),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: CatchmongColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "예약자 : ${reservation.user!.nickname}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CatchmongColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "연락처 : ${reservation.user?.phone}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CatchmongColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              Text(
                "${reservation.numOfPeople}명",
                style: TextStyle(
                  color: CatchmongColors.gray_800,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          reservation.status == "CONFIRMED"
              ? Container()
              : Row(
                  children: [
                    Expanded(
                      child: OutlinedBtn(title: "예약 취소", onPress: () {}),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: OutlinedBtn(
                        title: "예약 확정",
                        fontColor: CatchmongColors.blue2,
                        onPress: () {},
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
