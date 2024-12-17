import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InfoBtn extends StatelessWidget {
  const InfoBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showInfoDialog(context);
      },
      child: Image.asset(
        'assets/images/info-icon.png',
        width: 24, // 적절한 크기로 설정
        height: 24, // 적절한 크기로 설정
      ),
    );
  }

  // 초기 다이얼로그
  void showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "파트너 & 스토어 안내",
                style: TextStyle(
                    color: CatchmongColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 320,
                  height: 81,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 12.0, top: 28, bottom: 28),
                        child: Image.asset('assets/images/partner-marker.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "파트너",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: CatchmongColors.black),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "설명을 작성해주세요",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: CatchmongColors.gray_300),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: CatchmongColors.gray50,
                  thickness: 1,
                ),
                SizedBox(
                  width: 320,
                  height: 81,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 12.0, top: 28, bottom: 28),
                        child: Image.asset('assets/images/store-marker.png'),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 16.0, bottom: 16),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "스토어",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: CatchmongColors.black),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "설명을 작성해주세요",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: CatchmongColors.gray_300),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const Divider(
                  color: CatchmongColors.gray50,
                  thickness: 1,
                ),
                const SizedBox(height: 20),
                YellowElevationBtn(
                  onPressed: () {
                    Navigator.of(context).pop(); // 현재 다이얼로그 닫기
                    Get.toNamed("/main");
                  },
                  title: const Text(
                    "확인",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
