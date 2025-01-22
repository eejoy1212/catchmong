import 'dart:io';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/model/reservation_setting.dart';
import 'package:catchmong/modules/mypage/views/mypage_view.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/single_img_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/card/partner_img_card.dart';
import 'package:catchmong/widget/dropdown/border_droprown.dart';
import 'package:catchmong/widget/txtarea/border_txtarea.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class WrittenReservationRegisterSection extends StatelessWidget {
  final TextEditingController nameTxtController;
  final Function(String) onChangedName;
  final TextEditingController descriptionTxtController;
  final TextEditingController tableNumTxtController;
  final Function(String) onChangedDescription;
  final String selectedDayType;
  final String selectedMinuteType;
  final Function(String?) onChangedDayType;
  final Function(String?) onChangedMinuteType;
  final String selectedStartTime;
  final String selectedEndTime;
  final String selectedNumOfPeople;
  final Function(String) onChangedNumOfPeople;
  final Function(String) onChangedTableNum;
  final Function(String) onChangedStartTime;
  final Function(String) onChangedEndTime;
  final Function(XFile) onImageSelected;
  final void Function() onDeleteImg;
  final File? image;
  final ReservationSetting setting;
  const WrittenReservationRegisterSection({
    super.key,
    required this.nameTxtController,
    required this.onChangedName,
    required this.descriptionTxtController,
    required this.tableNumTxtController,
    required this.onChangedDescription,
    required this.selectedDayType,
    required this.onChangedDayType,
    required this.selectedStartTime,
    required this.selectedEndTime,
    required this.selectedMinuteType,
    required this.onChangedMinuteType,
    required this.selectedNumOfPeople,
    required this.onChangedNumOfPeople,
    required this.onChangedTableNum,
    required this.onImageSelected,
    required this.onDeleteImg,
    this.image,
    required this.onChangedStartTime,
    required this.onChangedEndTime,
    required this.setting,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
        child: Text("평일"),
        value: "평일",
      ),
      DropdownMenuItem(
        child: Text("주말"),
        value: "주말",
      ),
      DropdownMenuItem(
        child: Text("매일"),
        value: "매일",
      ),
    ];
    List<DropdownMenuItem<String>> minuteItems = [
      DropdownMenuItem(
        child: Text("30분"),
        value: "30분",
      ),
      DropdownMenuItem(
        child: Text("1시간"),
        value: "1시간",
      ),
    ];
    //   List<DropdownMenuItem<String>> minuteItems = [
    //   DropdownMenuItem(
    //     child: Text("30분"),
    //     value: "30분",
    //   ),
    //   DropdownMenuItem(
    //     child: Text("60분"),
    //     value: "60분",
    //   ),
    // ];
    List<String> numOfPeople =
        List.generate(13, (index) => index == 12 ? "인원문의전화" : "${index + 1}명");
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

    String getAvailabilityTitle(String value) {
      switch (value) {
        case "WEEKDAY":
          return "평일";
        case "WEEKEND":
          return "주말";
        case "DAILY":
          return "매일";
        default:
          return "매일";
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      color: Colors.white,
      width: width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PartnerImgCard(
                onDelete: () {},
                onTab: () {},
                path: !setting.reservationImage!.contains("uploads")
                    ? setting.reservationImage!
                    : "http://$myPort:3000/" + setting.reservationImage!,
                isLocal: !setting.reservationImage!.contains("uploads"),
              ),
              SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width - 160,
                    child: Text(
                        formatReservationPeriod(
                            setting.startTime, setting.endTime),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        )),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    width: width - 160,
                    child: Text(
                      setting.description ?? "",
                      style: TextStyle(
                        color: CatchmongColors.gray_800,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "요일",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  // BorderDroprown(
                  //   items: items,
                  //   selected: selectedDayType,
                  //   width: width - 160,
                  //   onChanged: onChangedDayType,
                  // ),
                  OutlinedBtn(
                      width: width - 160,
                      title: getAvailabilityTitle(setting.availabilityType),
                      onPress: () {}),
                  SizedBox(height: 8),
                  Text(
                    "시간",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                      width: width - 160,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  child: OutlinedBtn(
                                      title: DateFormat('HH:mm')
                                          .format(setting.startTime),
                                      onPress: () {})),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "-",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: OutlinedBtn(
                                      title: DateFormat('HH:mm')
                                          .format(setting.endTime),
                                      onPress: () {})),
                            ],
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          OutlinedBtn(
                              width: width - 160,
                              title: setting.timeUnit == "THIRTY_MIN"
                                  ? "30분"
                                  : "1시간",
                              onPress: () {})
                        ],
                      )),
                  SizedBox(height: 8),
                  Text(
                    "시간 당 예약 가능한 테이블 재고",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  OutlinedBtn(
                      width: width - 160,
                      title: setting.availableTables.toString() + "개",
                      onPress: () {}),
                  SizedBox(height: 8),
                  Text(
                    "인원수",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    width: width - 160,
                    child: Wrap(
                      spacing: 4, // 버튼 사이 간격
                      runSpacing: 4, // 줄바꿈 시 간격
                      children: [
                        ...numOfPeople.map((String num) {
                          return YellowToggleBtn(
                            width: num == "인원문의전화"
                                ? (width - 160)
                                : (width - 160) / 3 - 3, // 버튼 너비
                            title: num,
                            isSelected: setting.allowedPeople == num, // 기본 선택값
                            onTap: () => {},
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedBtn(
                  title: "수정",
                  onPress: () {},
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: OutlinedBtn(
                  title: "삭제",
                  onPress: () {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
