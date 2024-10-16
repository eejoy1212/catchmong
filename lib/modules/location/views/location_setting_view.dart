import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/widget/bar/LocationBar.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/GrayElevationBtn.dart';
import 'package:catchmong/widget/button/InfoBtn.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/slider/LocationSlider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationSettingView extends StatelessWidget {
  LocationSettingView({super.key});
  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    double _currentValue = 10.0; // 슬라이더 값

    // 다이얼로그를 화면이 렌더링된 후에 표시하기 위해 addPostFrameCallback 사용
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showInitialDialog(context);
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          InfoBtn(),
          SizedBox(width: 20),
        ],
        leading: AppbarBackBtn(),
        title: Text(
          "내 지역 설정",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            LocationBar(),
            Expanded(
              child: Container(
                child: Center(child: Text("지도")),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 초기 다이얼로그
  void showInitialDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "파트너, 스토어 방문을 위해 \n",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: "내 지역",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: "을 설정해보세요.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 296,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: const Color.fromARGB(255, 196, 185, 185),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Image.asset('assets/images/map.png'),
                        SizedBox(height: 40),
                        LocationBar(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                YellowElevationBtn(
                  onPressed: () {
                    Navigator.of(context).pop(); // 현재 다이얼로그 닫기
                    showRadiusDialog(context); // 반경 설정 다이얼로그 열기
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "다음",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Image.asset('assets/images/right-arrow.png')
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

  // 반경 설정 다이얼로그
  void showRadiusDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "원하는 거리만큼 \n",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                    TextSpan(
                      text: "반경",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: "을 조절해보세요.",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: 320,
                  height: 296,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: const Color.fromARGB(255, 196, 185, 185),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 20),
                        Image.asset('assets/images/map.png'),
                        SizedBox(height: 40),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: LocationSlider(currentValue: 10.0),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GrayElevationBtn(
                        onPressed: () {
                          Navigator.of(context).pop(); // 반경 설정 다이얼로그 닫기
                          showInitialDialog(context); // 내 지역 설정 다이얼로그 다시 열기
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/left-arrow.png'),
                            Text(
                              "이전",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 24),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: YellowElevationBtn(
                        onPressed: () {
                          Navigator.of(context).pop(); // 반경 설정 다이얼로그 닫기
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 24),
                            Text(
                              "다음",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Image.asset('assets/images/right-arrow.png')
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
