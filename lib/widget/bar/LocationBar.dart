import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/modules/location/views/location_search_view.dart';
import 'package:daum_postcode_search/daum_postcode_search.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';

class LocationBar extends StatelessWidget {
  final double opacity;
  final void Function(DataModel, double, double) onSearch;
  final String? nowAddress;
  const LocationBar({
    super.key,
    this.opacity = 0.6,
    required this.onSearch,
    this.nowAddress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(opacity), // 배경색을 검정으로, 투명도 40% 설정
      ),
      padding: EdgeInsets.all(8.0), // 텍스트와 컨테이너 사이에 여백을 추가할 수 있습니다.
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Text(
              nowAddress ?? "위치를 선택 해 주세요",
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis, // 오버플로우시 말줄임표 처리
              maxLines: 1, // 한 줄로 제한
              softWrap: false, // 텍스트 줄바꿈 비활성화
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.only(left: 8, right: 8, top: 4, bottom: 4),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            onPressed: () async {
              // Get.toNamed('/location-search');
              DataModel model = await Get.to(
                () => LocationSearchView(),
              );
              List<Location> locations =
                  await locationFromAddress(model.address);
              double latitude = locations[0].latitude;
              double longitude = locations[0].longitude;
              onSearch(model, latitude, longitude);
              print("주소 검색 결과>>> ${model.address}");
            },
            child: Text(
              "주소검색",
              style: TextStyle(fontSize: 14, color: CatchmongColors.black),
            ),
          ),
        ],
      ),
    );
  }
}
