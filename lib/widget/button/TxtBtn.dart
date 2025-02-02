import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TxtBtn extends StatelessWidget {
  const TxtBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 52,
      child: TextButton(
        onPressed: () {
          showFirstLookDialog(context);
        },
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 보더 반경 설정
          ),
        ),
        child: Text(
          "구경 먼저 할게요",
          style: TextStyle(
              color: CatchmongColors.sub_gray,
              fontWeight: FontWeight.w700,
              fontSize: 16), // 텍스트 색상 설정
        ),
      ),
    );
  }
}

void showFirstLookDialog(BuildContext context) {
  final Partner2Controller partnerController = Get.find<Partner2Controller>();
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(0),
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 20,
                ),
                child: Text(
                  "내 지역 미설정 시, 기본 주소는 모든 지역으로 저장됩니다.",
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: CatchmongColors.gray_300))),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "취소",
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 1, // 버튼 사이의 구분선
                      height: 60,
                      color: CatchmongColors.gray_300,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          // 확인 버튼의 동작 추가
                          partnerController.isAll.value = true;
                          Get.toNamed('/main');
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 60,
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            "확인",
                            style: TextStyle(
                              color: CatchmongColors.red,
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
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
