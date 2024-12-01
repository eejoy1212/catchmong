import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/widget/bar/LocationBar.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/GrayElevationBtn.dart';
import 'package:catchmong/widget/button/InfoBtn.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/map/custom_map.dart';
import 'package:catchmong/widget/slider/LocationSlider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationSettingView extends StatelessWidget {
  LocationSettingView({super.key});
  final LocationController controller = Get.find<LocationController>();

  // 현재 위치를 가져오는 메서드
  Future<NLatLng> _getCurrentPosition() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();
    return NLatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    double _currentValue = 10.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          const InfoBtn(),
          const SizedBox(width: 20),
        ],
        leading: const AppbarBackBtn(),
        title: const Text(
          "내 지역 설정",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: CatchmongColors.black,
          ),
        ),
      ),
      body: FutureBuilder<NLatLng>(
          future: _getCurrentPosition(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final currentPosition = snapshot.data!;

              // 지도 로딩 후 다이얼로그와 바텀시트 표시
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showBottomSheet(context);
                showInitialDialog(context);
              });

              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const LocationBar(
                      opacity: 0.4,
                    ),
                    Expanded(
                        child: CustomMap(currentPosition: currentPosition)),
                  ],
                ),
              );
            }
          }),
    );
  }

  void showInitialDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Stack(
            alignment: Alignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      // text: "파트너, 스토어 방문을 위해 \n",
                      text: "파트너 방문을 위해 \n",
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
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: const Color.fromARGB(255, 196, 185, 185),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Image.asset('assets/images/map.png'),
                        const SizedBox(height: 40),
                        const LocationBar(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                YellowElevationBtn(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showRadiusDialog(context);
                  },
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "다음",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      Image.asset('assets/images/right-arrow-white.png')
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

  void showRadiusDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Stack(
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
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: const Color.fromARGB(255, 196, 185, 185),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Image.asset('assets/images/map.png'),
                        const SizedBox(height: 40),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: LocationSlider(currentValue: 10.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: GrayElevationBtn(
                        onPressed: () {
                          Navigator.of(context).pop();
                          showInitialDialog(context);
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/left-arrow-white.png'),
                            const Text(
                              "이전",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: YellowElevationBtn(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "다음",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                            Image.asset('assets/images/right-arrow-white.png')
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

  void showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,

      showDragHandle: false, //아래로 슬라이드 해서 바텀시트 닫는 변수
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 52,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "파트너",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: CatchmongColors.sub_gray),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "10개",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: CatchmongColors.black),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      thickness: 1,
                      color: CatchmongColors.gray,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "스토어",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: CatchmongColors.sub_gray),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "10개",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: CatchmongColors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const LocationSlider(currentValue: 10.0),
              const SizedBox(height: 24),
              YellowElevationBtn(
                onPressed: () {
                  Get.back();
                },
                title: const Text(
                  "저장하기",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
