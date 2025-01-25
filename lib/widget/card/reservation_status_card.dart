import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/controller/reservation_controller.dart';
import 'package:catchmong/model/reservation.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/txtarea/border_txtarea.dart';
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

    final ReservationConteroller reservationConteroller =
        Get.find<ReservationConteroller>();
    return Opacity(
      opacity:
          reservation.status == "COMPLETED" || reservation.status == "CANCELLED"
              ? 0.6
              : 1,
      child: Container(
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
                      formatCreatedAt(reservation.reservationStartDate),
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
                      formatReservationTimeWithWeekday([
                        reservation.reservationStartDate,
                        reservation.reservationEndDate
                      ]),
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
                        child: OutlinedBtn(
                            title: "예약 취소",
                            onPress: () {
                              showCancelDialog(context, reservation.id);
                            }),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: OutlinedBtn(
                          title: "예약 확정",
                          fontColor: CatchmongColors.blue2,
                          onPress: () async {
                            final res = await reservationConteroller
                                .patchConfirmReservation(reservation.id);
                            // 예제: 컨트롤러의 예약 리스트를 업데이트하는 코드
                            if (res != null) {
                              reservationConteroller.myReservations[
                                  reservationConteroller.myReservations
                                      .indexWhere((el) =>
                                          el.id == reservation.id)] = res;
                              reservationConteroller.myReservations.refresh();
                              Get.snackbar(
                                "알림",
                                "예약이 확정되었습니다.",
                                snackPosition: SnackPosition.TOP, // 상단에 표시
                                backgroundColor: CatchmongColors.yellow_main,
                                colorText: CatchmongColors.black,
                                icon: Icon(
                                  Icons.check_circle,
                                  color: CatchmongColors.black,
                                ),
                                duration: Duration(seconds: 1),
                                borderRadius: 10,
                                margin: EdgeInsets.all(10),
                              );
                            }
                          },
                        ),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}

//취소하기 창
void showCancelDialog(BuildContext context, int reservationId) {
  String selectedReason = ""; // 선택된 취소 사유를 저장할 변수
  double width = MediaQuery.of(context).size.width;
  final TextEditingController txtController = TextEditingController();
  final List<String> reasons = [
    "임시 휴업/영업 시간 변경",
    "예약 시간 중복",
    "재료 소진",
    "고객 연락 두절",
    "기타 (직접 입력)",
  ];
  final ReservationConteroller conteroller = Get.find<ReservationConteroller>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          "고객님께 예약 취소 사유를 알려주세요 🥲",
          style: TextStyle(
            color: CatchmongColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: SizedBox(
          height: 550, // 리스트 높이 조정
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // 라디오 버튼과 텍스트 리스트
              Expanded(
                child: ListView.separated(
                  itemCount: reasons.length + 1,
                  separatorBuilder: (context, index) => Divider(
                    color: reasons.length - 1 == index
                        ? Colors.transparent
                        : CatchmongColors.gray50, // 구분선 색상
                    thickness: 1,
                  ),
                  itemBuilder: (context, index) {
                    return index == reasons.length
                        ? SizedBox(
                            width: width,
                            height: 100,
                            child: Obx(() => BorderTxtarea(
                                readOnly: conteroller.ceoReasonIdx.value != 3,
                                width: width,
                                hintText: "내용을 작성해주세요.",
                                controller: txtController,
                                onChanged: (String value) {
                                  conteroller.ceoCancelReason.value = value;
                                  if (txtController.text.length > 300) {
                                    Future.microtask(() {
                                      txtController.value = TextEditingValue(
                                        text: value.substring(0, 300),
                                        selection: TextSelection.collapsed(
                                            offset: 300),
                                      );
                                    });
                                  }
                                })),
                          )
                        : ListTile(
                            contentPadding: EdgeInsets.all(0),
                            leading: Obx(() => Radio<String>(
                                  activeColor: CatchmongColors.yellow_main,
                                  value: reasons[index],
                                  groupValue:
                                      reasons[conteroller.ceoReasonIdx.value],
                                  onChanged: (String? value) {
                                    if (value != null) {
                                      conteroller.ceoReasonIdx.value = index;
                                      if (index == 3) {
                                        conteroller.ceoCancelReason.value = "";
                                      } else {
                                        conteroller.ceoCancelReason.value =
                                            value;
                                      }
                                    }
                                  },
                                )),
                            title: Text(reasons[index]),
                          );
                  },
                ),
              ),
              SizedBox(
                width: width,
                child: Row(
                  children: [
                    Expanded(
                      child: YellowElevationBtn(
                        onPressed: () async {
                          print(
                              "선택된 취소 사유: ${conteroller.ceoCancelReason.value}");
                          if (conteroller.ceoCancelReason.value.trim() == "") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("취소 사유를 선택해주세요.")),
                            );
                            return;
                          }
                          final reservation =
                              await conteroller.patchCancelReservation(
                                  reservationId: reservationId);
                          if (reservation != null) {
                            int index = conteroller.myReservations
                                .indexWhere((el) => el.id == reservationId);

                            if (index != -1) {
                              // 기존 요소를 업데이트
                              conteroller.myReservations[index] = reservation;
                              conteroller.myReservations
                                  .refresh(); // RxList 변경 사항 반영
                            } else {
                              print('해당 ID를 가진 예약이 리스트에 없습니다: $reservationId');
                            }
                            Get.back(); // 다이얼로그 닫기
                            Get.snackbar(
                              "알림",
                              "예약이 취소되었습니다.",
                              snackPosition: SnackPosition.TOP, // 상단에 표시
                              backgroundColor: CatchmongColors.yellow_main,
                              colorText: CatchmongColors.black,
                              icon: Icon(Icons.check_circle,
                                  color: CatchmongColors.black),
                              duration: Duration(seconds: 1),
                              borderRadius: 10,
                              margin: EdgeInsets.all(10),
                            );
                            // 선택된 취소 사유 처리
                          }
                        },
                        title: Text(
                          "확인",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: YellowElevationBtn(
                        onPressed: () {
                          Get.back(); // 다이얼로그 닫기
                          // 선택된 취소 사유 처리
                          print(
                              "선택된 취소 사유: ${conteroller.ceoCancelReason.value}");
                        },
                        title: Text(
                          "취소",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
