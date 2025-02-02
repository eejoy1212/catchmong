// import 'package:catchmong/const/catchmong_colors.dart';
// import 'package:catchmong/modules/location/controllers/location_controller.dart';
// import 'package:catchmong/widget/bar/map_searchbar.dart';
// import 'package:catchmong/widget/chip/map_chip.dart';
// import 'package:catchmong/widget/map/custom_map.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_naver_map/flutter_naver_map.dart';
// import 'package:geolocator/geolocator.dart';

// class MapContent extends StatelessWidget {
//   MapContent({super.key});

//   final LocationController locationController = LocationController();
//   final NaverMapController? _mapController = null;

//   // 현재 위치를 가져오는 메서드
//   Future<NLatLng> _getCurrentPosition() async {
//     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }

//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     Position position = await Geolocator.getCurrentPosition();
//     return NLatLng(position.latitude, position.longitude);
//   }

//   @override
//   Widget build(BuildContext context) {
//     //지우지 마세요
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       showBottomSheet(context);
//     });
//     return SafeArea(
//       child: FutureBuilder<NLatLng>(
//         future: _getCurrentPosition(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else {
//             final currentPosition = snapshot.data!;
//             final marker = NCircleOverlay(
//               id: "marker",
//               center: currentPosition,
//               radius: 16,
//               color: CatchmongColors.green_line,
//             );

//             // `Column` 안에 `NaverMap`과 `Text`를 함께 넣기 위해 이 위치에서 `NaverMap`을 초기화함
//             return Column(
//               children: [
//                 Container(
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         height: 16,
//                       ),
//                       Container(
//                           margin: EdgeInsets.symmetric(
//                             horizontal: 20,
//                           ),
//                           child: MapSearchbar()),
//                       SizedBox(
//                         height: 16,
//                       ),
//                       // Container(
//                       //   margin: EdgeInsets.symmetric(
//                       //     horizontal: 20,
//                       //   ),
//                       //   child: Row(
//                       //     children: [
//                       //       MapChip(
//                       //         title: '전체',
//                       //         isActive: true,
//                       //       ),
//                       //       MapChip(
//                       //         title: '전체',
//                       //         isActive: true,
//                       //       )
//                       //     ],
//                       //   ),
//                       // ),
//                       // SizedBox(
//                       //   height: 16,
//                       // ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: CustomMap(currentPosition: currentPosition),
//                 ),
//               ],
//             );
//           }
//         },
//       ),
//     );
//   }
// }

// void showBottomSheet(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     isDismissible: false, // 바텀시트를 밖으로 내려서 닫지 못하게 설정
//     enableDrag: true, // 드래그로 높이를 조절할 수 있게 설정
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//     ),
//     builder: (BuildContext context) {
//       return DraggableScrollableSheet(
//         snap: false,
//         expand: false, // 드래그로 스크롤이 확장되지 않도록 설정
//         initialChildSize: 120 / 606, // 초기 높이 비율 설정
//         minChildSize: 120 / 606, // 최소 높이 비율 설정
//         maxChildSize: 1.0, // 최대 높이를 전체 화면으로 설정
//         builder: (BuildContext context, ScrollController scrollController) {
//           return Padding(
//             padding: const EdgeInsets.all(20),
//             child: Column(
//               children: [
//                 // 인디케이터 추가
//                 Container(
//                   width: 40,
//                   height: 4,
//                   margin: const EdgeInsets.only(bottom: 10),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[300],
//                     borderRadius: BorderRadius.circular(2),
//                   ),
//                 ),
//                 // 바텀시트의 콘텐츠
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: [
//                       MapChip(
//                         useLeadingIcon: true,
//                         title: "필터",
//                         isActive: false,
//                         marginRight: 8,
//                         leadingIcon:
//                             Image.asset('assets/images/filter-icon.png'),
//                       ),
//                       SizedBox(width: 8),
//                       MapChip(
//                         useLeadingIcon: true,
//                         title: "영업중",
//                         isActive: false,
//                         marginRight: 8,
//                         leadingIcon:
//                             Image.asset('assets/images/filter-icon.png'),
//                       ),
//                       SizedBox(width: 8),
//                       MapChip(
//                         useLeadingIcon: true,
//                         title: "예약",
//                         isActive: false,
//                         marginRight: 8,
//                         leadingIcon:
//                             Image.asset('assets/images/filter-icon.png'),
//                       ),
//                       SizedBox(width: 8),
//                       MapChip(
//                         useLeadingIcon: true,
//                         title: "픽업",
//                         isActive: false,
//                         marginRight: 8,
//                         leadingIcon:
//                             Image.asset('assets/images/filter-icon.png'),
//                       ),
//                       SizedBox(width: 8),
//                       MapChip(
//                         useLeadingIcon: true,
//                         title: "주차",
//                         isActive: false,
//                         marginRight: 8,
//                         leadingIcon:
//                             Image.asset('assets/images/parking-icon.png'),
//                       ),
//                       SizedBox(width: 8),
//                       MapChip(
//                         useLeadingIcon: true,
//                         title: "쿠폰",
//                         isActive: false,
//                         marginRight: 8,
//                         leadingIcon:
//                             Image.asset('assets/images/coupon-icon.png'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//     },
//   );
// }
import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/widget/bar/map_searchbar.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:catchmong/widget/content/scrap_partner_content.dart';
import 'package:catchmong/widget/map/custom_map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class MapContent extends StatelessWidget {
  MapContent({super.key});

  // final LocationController locationController = Get.find<LocationController>();
  final Partner2Controller partnercontroller = Get.find<Partner2Controller>();
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
    final pos = partnercontroller.nowPosition.value;
    // await partnercontroller.fetchNearbyPartners(position: position);
    return pos;
  }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   showBottomSheet(context);
    // });

    return SafeArea(
      child: FutureBuilder<NLatLng>(
        future: _getCurrentPosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final currentPosition = snapshot.data!;
            return Stack(
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
                      child: CustomMap(
                        currentPosition: currentPosition,
                        onMapReady: (naverMapController) async {
                          // naverMapController.clearOverlays();

                          // List<NMarker> markers = await partnerController.fetchNearbyPartners();
                          // naverMapController.addOverlayAll(markers.toSet());
                        },
                        options: NaverMapViewOptions(),
                        onCameraChange: (NCameraUpdateReason, bool) {},
                        onCameraIdle: () {},
                      ),
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
            );
          }
        },
      ),
    );
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
