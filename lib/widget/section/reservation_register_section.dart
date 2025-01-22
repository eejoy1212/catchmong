import 'dart:io';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/mypage/views/mypage_view.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/single_img_btn.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/dropdown/border_droprown.dart';
import 'package:catchmong/widget/txtarea/border_txtarea.dart';
import 'package:catchmong/widget/txtfield/border-txtfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ReservationRegisterSection extends StatelessWidget {
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
  final Function(DateTime) onChangedStartTime;
  final Function(DateTime) onChangedEndTime;
  final Function(XFile) onImageSelected;
  final void Function() onDeleteImg;
  final File? image;
  const ReservationRegisterSection({
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
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              color: CatchmongColors.gray50,
              width: 1,
            ),
          )),
      width: width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleImgBtn(
            image: image,
            onImageSelected: onImageSelected,
            onDelete: onDeleteImg,
          ),
          SizedBox(
            width: 12,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "예약 상품명",
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
                child: BorderTxtField(
                  hintText: "예약 상품명을 입력해주세요",
                  controller: nameTxtController,
                  onChanged: onChangedName,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "상세 설명",
                style: TextStyle(
                  color: CatchmongColors.gray_800,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4,
              ),
              BorderTxtarea(
                hintText: "내용을 입력해주세요",
                controller: descriptionTxtController,
                onChanged: onChangedDescription,
                width: width - 160,
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
              BorderDroprown(
                items: items,
                selected: selectedDayType,
                width: width - 160,
                onChanged: onChangedDayType,
              ),
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
                                  title: selectedStartTime,
                                  onPress: () {
                                    showWheelPicker(context, (String value) {
                                      // 현재 날짜 가져오기
                                      final now = DateTime.now();

                                      // 선택한 시간 문자열 "01:00" 분리
                                      final parts = value.split(':');
                                      final hour = int.parse(parts[0]);
                                      final minute = int.parse(parts[1]);

                                      // 현재 날짜 + 선택한 시간으로 새로운 DateTime 생성
                                      final selectedDateTime = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          hour,
                                          minute);

                                      // DateTime 객체를 변수에 할당
                                      onChangedStartTime(selectedDateTime);

                                      print(
                                          "선택한 시간: $value, DateTime 객체: $selectedDateTime");
                                    });
                                  })),
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
                                  title: selectedEndTime,
                                  onPress: () {
                                    // if (controller.isAllDay.isFalse) {
                                    showWheelPicker(context, (String value) {
                                      // 현재 날짜 가져오기
                                      final now = DateTime.now();

                                      // 선택한 시간 문자열 "01:00" 분리
                                      final parts = value.split(':');
                                      final hour = int.parse(parts[0]);
                                      final minute = int.parse(parts[1]);

                                      // 현재 날짜 + 선택한 시간으로 새로운 DateTime 생성
                                      final selectedDateTime = DateTime(
                                          now.year,
                                          now.month,
                                          now.day,
                                          hour,
                                          minute);

                                      // DateTime 객체를 변수에 할당
                                      onChangedEndTime(selectedDateTime);

                                      print(
                                          "선택한 시간: $value, DateTime 객체: $selectedDateTime");
                                    });
                                    // }
                                  })),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      BorderDroprown(
                        items: minuteItems,
                        selected: selectedMinuteType,
                        width: width - 160,
                        onChanged: onChangedMinuteType,
                      ),
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
              SizedBox(
                width: width - 160,
                child: BorderTxtField(
                  textInputType: TextInputType.number,
                  hintText: "테이블 재고를 입력해주세요",
                  controller: tableNumTxtController,
                  onChanged: onChangedTableNum,
                ),
              ),
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
                        isSelected: selectedNumOfPeople == num, // 기본 선택값
                        onTap: () => onChangedNumOfPeople(num),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
