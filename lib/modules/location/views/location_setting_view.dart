import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/modules/location/views/location_search_view.dart';
import 'package:catchmong/widget/bar/LocationBar.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/GrayElevationBtn.dart';
import 'package:catchmong/widget/button/InfoBtn.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:catchmong/widget/map/custom_map.dart';
import 'package:catchmong/widget/slider/LocationSlider.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationSettingView extends StatelessWidget {
  LocationSettingView({super.key});
  final LocationController controller = Get.find<LocationController>();
  final Partner2Controller partnerController = Get.find<Partner2Controller>();
  // 현재 위치를 가져오는 메서드
  // Future<NLatLng> _getCurrentPosition() async {
  //   bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     return Future.error('Location services are disabled.');
  //   }

  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   Position position = await Geolocator.getCurrentPosition();
  //   return NLatLng(position.latitude, position.longitude);
  // }

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
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Obx(() => LocationBar(
                  opacity: 0.4,
                  nowAddress: partnerController.nowAddress.value,
                  onSearch: (DataModel newData, double latitude,
                      double longitude) async {
                    final address =
                        "${newData.roadAddress},${newData.sigungu},${newData.sido},${newData.zonecode}";
                    partnerController.nowPosition.value =
                        NLatLng(latitude, longitude);

                    partnerController.nowAddress.value = address;

                    ///마커추가
                    final markers = await partnerController.fetchNearbyPartners(
                        latitude, longitude);
                    partnerController.naverMapController.value
                        ?.addOverlayAll(markers.toSet());
                    if (partnerController.nowRadius.value >= 100000.0) return;
                    final cameraUpdate = NCameraUpdate.withParams(
                      target: NLatLng(latitude, longitude),
                      zoomBy: -2,
                      bearing: 180,
                    );
                    partnerController.naverMapController.value
                        ?.updateCamera(cameraUpdate);
                  })),
              Expanded(
                  child: Obx(() => CustomMap(
                      currentPosition: partnerController.nowPosition.value,
                      onMapReady: (naverMapController) async {
                        partnerController.naverMapController.value =
                            naverMapController;
                        // await partnerController.getLocationFromStorage();
                        final markers =
                            await partnerController.fetchNearbyPartners(
                                partnerController.nowPosition.value.latitude,
                                partnerController.nowPosition.value.longitude);
                        partnerController.naverMapController.value
                            ?.addOverlayAll(markers.toSet());
                        // 지도 로딩 후 다이얼로그와 바텀시트 표시
                        partnerController.isRadiusDialog.value = true;
                        partnerController.isRadiusBottomSheet.value = true;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          showBottomSheet(context);
                          showInitialDialog(context);
                        });
                      },
                      options: NaverMapViewOptions(
                        initialCameraPosition: NCameraPosition(
                          target: partnerController.nowPosition.value,
                          zoom: 15,
                        ),
                      ),
                      onCameraChange: (reason, isGesture) async {
                        if (partnerController.naverMapController.value !=
                            null) {
                          if (partnerController.isRadiusDialog.isTrue ||
                              partnerController.isRadiusBottomSheet.isTrue)
                            return;
                          //반경계산
                          //위치 보장 안돼서 가끔 에러남
                          // final NCameraPosition position =
                          //     await partnerController.naverMapController.value!
                          //         .getCameraPosition(); // 현재 지도 위치 정보 가져오기
                          final NCameraPosition position = partnerController
                              .naverMapController
                              .value!
                              .nowCameraPosition; // 현재 지도 위치 정보 가져오기
                          final NLatLng center = position.target; // 현재 지도 중심 좌표
                          final double zoom = position.zoom; // 현재 지도 줌 레벨

                          // zoomLevel.value = zoom; // 줌 레벨 업데이트

                          // 📌 지도 반경 계산 공식: 줌 레벨에 따라 조정된 값 사용
                          final double adjustedRadius =
                              partnerController.getRadiusByZoom(zoom);

                          partnerController.nowRadius.value = adjustedRadius;
                          print(
                              "📏 현재 지도 반경: ${adjustedRadius.toStringAsFixed(2)}m (줌 레벨: $zoom)");
                          //반경계산
                          // final NCameraPosition position =
                          //     await partnerController.naverMapController.value!
                          //         .getCameraPosition();

                          final latitude = position.target.latitude;
                          final longitude = position.target.longitude;

                          // 🔥 현재 카메라 위치와 새로운 위치의 변화가 없으면 업데이트 중지
                          if (partnerController.nowPosition.value.latitude ==
                                  latitude &&
                              partnerController.nowPosition.value.longitude ==
                                  longitude) {
                            return;
                          }

                          // 🔥 마지막 카메라 위치 업데이트
                          partnerController.nowPosition.value =
                              NLatLng(latitude, longitude);

                          // print("📍 지도 이동 중... 위치: $latitude, $longitude");
                          // final markers = await partnerController
                          //     .fetchNearbyPartners(latitude, longitude);
                          // partnerController.naverMapController.value!
                          //     .addOverlayAll(markers.toSet());
                        }
                      },
                      onCameraIdle: () async {
                        if (partnerController.naverMapController.value !=
                            null) {
                          if (partnerController.isRadiusDialog.isTrue ||
                              partnerController.isRadiusBottomSheet.isTrue)
                            return;

                          final NCameraPosition position = partnerController
                              .naverMapController.value!.nowCameraPosition;

                          final latitude = position.target.latitude;
                          final longitude = position.target.longitude;

                          print("✅ 지도 이동 완료! 위치: $latitude, $longitude");
                          // partnerController.naverMapController.value!
                          //     .clearOverlays();
                          // 📌 지도 이동이 끝난 후에만 마커 추가
                          final markers = await partnerController
                              .fetchNearbyPartners(latitude, longitude);
                          partnerController.naverMapController.value
                              ?.addOverlayAll(markers.toSet());
                        }
                      }))),
            ],
          ),
        ));
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
                        Obx(() => LocationBar(
                            nowAddress: partnerController.nowAddress.value,
                            onSearch: (DataModel newData, double latitude,
                                double longitude) {
                              // controller.setLocation(newData);
                              // final langitude = newData.l
                              final address =
                                  "${newData.roadAddress},${newData.sigungu},${newData.sido},${newData.zonecode}";
                              partnerController.nowPosition.value =
                                  NLatLng(latitude, longitude);
                              partnerController.nowAddress.value = address;
                              // controller.fetchCoordinates(newData.roadAddress ??
                              //     newData.jibunAddress ??
                              //     "");
                            })),
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
    ).then((_) {
      partnerController.isRadiusDialog.value = true;
    });
  }

  void showRadiusDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // final LocationController controller = Get.find<LocationController>();
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
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Obx(() => LocationSlider(
                                currentValue: partnerController.nowRadius.value,
                                onChange: (double val) {
                                  if (val > 100000.0) return;
                                  partnerController.nowRadius.value = val;
                                  print("슬라이더 값>>>$val");
                                },
                                onChangeEnd: (double val) async {
                                  if (val > 100000.0) return;
                                  final latitude = partnerController
                                      .nowPosition.value.latitude;
                                  final longitude = partnerController
                                      .nowPosition.value.longitude;
                                  final markers = await partnerController
                                      .fetchNearbyPartners(latitude, longitude);
                                  partnerController.naverMapController.value
                                      ?.addOverlayAll(markers.toSet());
                                  // 📌 반경을 기반으로 줌 레벨 계산
                                  final double zoomLevel = partnerController
                                      .getZoomLevelByRadius(val);

                                  print("🔍 반경 조절 → 새 줌 레벨: $zoomLevel");
                                  final cameraUpdate = NCameraUpdate.withParams(
                                    target: NLatLng(latitude, longitude),
                                    zoom: zoomLevel,
                                    // zoomBy: -2,
                                    bearing: 180,
                                  );
                                  partnerController.naverMapController.value
                                      ?.updateCamera(cameraUpdate);
                                },
                                nowAddress: partnerController.nowAddress.value,
                                isAll: partnerController.isAll.value,
                              )),
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
                          partnerController.isRadiusDialog.value = false;
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
                          partnerController.isRadiusDialog.value = false;
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
    partnerController.isRadiusBottomSheet.value = true;
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
        final LocationController controller = Get.find<LocationController>();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
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
                          Obx(() => Text(
                                partnerController.markerNum.value.toString(),
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: CatchmongColors.black),
                              )),
                        ],
                      ),
                    ),
                    // VerticalDivider(
                    //   thickness: 1,
                    //   color: CatchmongColors.gray,
                    // ),
                    // Expanded(
                    //   child: Column(
                    //     children: [
                    //       Text(
                    //         "스토어",
                    //         style: TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w400,
                    //             color: CatchmongColors.sub_gray),
                    //       ),
                    //       SizedBox(height: 8),
                    //       Text(
                    //         "10개",
                    //         style: TextStyle(
                    //             fontSize: 16,
                    //             fontWeight: FontWeight.w700,
                    //             color: CatchmongColors.black),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => LocationSlider(
                    currentValue: partnerController.nowRadius.value,
                    onChange: (double val) {
                      if (val > 100000.0) return;
                      partnerController.nowRadius.value = val;
                      print("슬라이더 값>>>$val");
                    },
                    onChangeEnd: (double val) async {
                      if (val > 100000.0) return;
                      final latitude =
                          partnerController.nowPosition.value.latitude;
                      final longitude =
                          partnerController.nowPosition.value.longitude;
                      final markers = await partnerController
                          .fetchNearbyPartners(latitude, longitude);
                      partnerController.naverMapController.value
                          ?.addOverlayAll(markers.toSet());
                      // 📌 반경을 기반으로 줌 레벨 계산
                      final double zoomLevel =
                          partnerController.getZoomLevelByRadius(val);

                      print("🔍 반경 조절 → 새 줌 레벨: $zoomLevel");
                      final cameraUpdate = NCameraUpdate.withParams(
                        target: NLatLng(latitude, longitude),
                        // zoomBy: -2,
                        bearing: 180,
                        zoom: zoomLevel,
                      );
                      partnerController.naverMapController.value
                          ?.updateCamera(cameraUpdate);
                    },
                    nowAddress: partnerController.nowAddress.value,
                    isAll: partnerController.isAll.value,
                  )),
              const SizedBox(height: 24),
              YellowElevationBtn(
                onPressed: () {
                  // Get.back();
                  Get.toNamed('/main');
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
    ).then((_) {
      partnerController.isRadiusBottomSheet.value = false;
    });
  }
}
