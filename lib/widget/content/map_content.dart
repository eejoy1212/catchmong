import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/widget/bar/map_searchbar.dart';
import 'package:catchmong/widget/bottom_sheet/filter_bottomsheet.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:catchmong/widget/content/scrap_partner_content.dart';
import 'package:catchmong/widget/map/custom_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MapContent extends StatelessWidget {
  MapContent({super.key});

  // final LocationController locationController = Get.find<LocationController>();
  final Partner2Controller partnerController = Get.find<Partner2Controller>();
  final NaverMapController? _mapController = null;
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  Future<NLatLng> _getCurrentPosition() async {
    // bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    //   return Future.error('Location services are disabled.');
    // }

    // LocationPermission permission = await Geolocator.checkPermission();
    // if (permission == LocationPermission.denied) {
    //   permission = await Geolocator.requestPermission();
    //   if (permission == LocationPermission.denied) {
    //     return Future.error('Location permissions are denied');
    //   }
    // }

    // if (permission == LocationPermission.deniedForever) {
    //   return Future.error(
    //       'Location permissions are permanently denied, we cannot request permissions.');
    // }

    // Position position = await Geolocator.getCurrentPosition();
    // print("my position>>>(${position.latitude},${position.longitude})");
    final pos = partnerController.nowPosition.value;
    // await partnercontroller.fetchNearbyPartners(position: position);
    return pos;
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showFilterBottomSheet(context);
    // });

    return SafeArea(
        child: Stack(
      children: [
        Column(
          children: [
            Container(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: MapSearchbar()),
                  SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
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
                    },
                    options: NaverMapViewOptions(
                      initialCameraPosition: NCameraPosition(
                        target: partnerController.nowPosition.value,
                        zoom: 15,
                      ),
                    ),
                    onCameraChange:
                        (NCameraUpdateReason reason, bool isGesture) {
                      if (partnerController.naverMapController.value != null) {
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
                      }
                    },
                    onCameraIdle: () async {
                      if (partnerController.naverMapController.value != null) {
                        final NCameraPosition position = partnerController
                            .naverMapController.value!.nowCameraPosition;

                        final latitude = position.target.latitude;
                        final longitude = position.target.longitude;

                        print("✅ 지도 이동 완료! 위치: $latitude, $longitude");
                        // partnerController.naverMapController.value!
                        //     .clearOverlays();
                        // 📌 지도 이동이 끝난 후에만 마커 추가
                        // final markers = await partnerController
                        //     .fetchNearbyPartners(latitude, longitude);
                        partnerController.naverMapController.value
                            ?.addOverlayAll(partnerController.markers.toSet());
                        // await partnerController.filterMarkers();
                      }
                    },
                  )),
            ),
          ],
        ),
        Positioned(
          bottom: 60, // BottomSheet 높이 + 4 위에 위치
          right: 16,
          child: GestureDetector(
            onTap: () {
              // bottomNavController.isShowingPartner.value = true;
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) =>
              //         ScrapPartnerContent(), // 새 페이지로 이동
              //   ),
              // );
              // Get.toNamed("/scrap");
            },
            child: Container(
              width: 100,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: CatchmongColors.gray,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/hambergur.svg'),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "목록보기",
                      style: TextStyle(
                        color: CatchmongColors.sub_gray,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    enableDrag: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        snap: false,
        expand: false,
        initialChildSize: 120 / 606,
        minChildSize: 120 / 606,
        maxChildSize: 1.0,
        builder: (BuildContext context, ScrollController scrollController) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      MapChip(
                        useLeadingIcon: true,
                        title: "필터",
                        isActive: false,
                        marginRight: 8,
                        leadingIcon:
                            Image.asset('assets/images/filter-icon.png'),
                      ),
                      SizedBox(width: 8),
                      MapChip(
                        useLeadingIcon: true,
                        title: "영업중",
                        isActive: false,
                        marginRight: 8,
                        leadingIcon:
                            Image.asset('assets/images/filter-icon.png'),
                      ),
                      MapChip(
                        useLeadingIcon: true,
                        title: "예약",
                        isActive: false,
                        marginRight: 8,
                        leadingIcon:
                            Image.asset('assets/images/filter-icon.png'),
                      ),
                      MapChip(
                        useLeadingIcon: true,
                        title: "픽업",
                        isActive: false,
                        marginRight: 8,
                        leadingIcon:
                            Image.asset('assets/images/filter-icon.png'),
                      ),
                      MapChip(
                        useLeadingIcon: true,
                        title: "주차",
                        isActive: false,
                        marginRight: 8,
                        leadingIcon:
                            Image.asset('assets/images/parking-icon.png'),
                      ),
                      MapChip(
                        useLeadingIcon: true,
                        title: "쿠폰",
                        isActive: false,
                        marginRight: 8,
                        leadingIcon:
                            Image.asset('assets/images/coupon-icon.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
