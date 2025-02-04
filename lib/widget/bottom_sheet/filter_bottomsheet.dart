import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/yellow-toggle-btn.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterBottomSheet extends StatelessWidget {
  final String sortType;
  final String timeType;
  final String eatType;
  final String foodType;
  final String serviceType;
  final bool isMini;
  final bool isFilter;
  final void Function(String type) onSelectSort;
  final void Function(String type) onSelectBusinessTime;
  final void Function(String type) onSelectEatType;
  final void Function(String type) onSelectFoodType;
  final void Function(String type) onSelectServiceType;
  final void Function() onInit;
  final void Function() onFilter;
  final void Function(double size) onMinimize;

  const FilterBottomSheet(
      {super.key,
      required this.onSelectSort,
      required this.onSelectBusinessTime,
      required this.sortType,
      required this.timeType,
      required this.eatType,
      required this.onSelectEatType,
      required this.foodType,
      required this.onSelectFoodType,
      required this.serviceType,
      required this.onSelectServiceType,
      required this.onInit,
      required this.onMinimize,
      required this.isMini,
      required this.onFilter,
      required this.isFilter});

  @override
  Widget build(BuildContext context) {
    String _getAmenity(String amenity) {
      switch (amenity) {
        case "아기의자":
          return "baby";
        case "쿠폰":
          return "coupon";
        case "주차":
          return "parking";
        case "애견동반":
          return "pet";
        default:
          return "";
      }
    }

    final DraggableScrollableController controller =
        DraggableScrollableController();
    controller.addListener(() {
      onMinimize(controller.size);
    });
    return SafeArea(
      top: false,
      // bottom: false,
      child: DraggableScrollableSheet(
        controller: controller,
        initialChildSize: 0.5, // 처음 표시되는 크기 (화면 높이의 50%)
        minChildSize: 0.16, // 최소 크기 (화면 높이의 30%)
        maxChildSize: 0.9, // 최대 크기 (화면 높이의 90%)
        expand: false, // 드래그로 최대 크기로 확장 불가능
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              // borderRadius: BorderRadius.vertical(
              //   top: Radius.circular(20),
              // ),
            ),
            child: ListView(
              controller: scrollController, // 스크롤 컨트롤러 연결
              children: [
                // 상단 핸들
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                // 필터 제목
                // 필터 제목
                if (isMini)
                  SizedBox(
                    height: 40, // 아이템의 높이를 설정하여 스크롤이 정상 작동하도록 함
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal, // 가로 스크롤 설정
                      child: Row(
                        children: [
                          MapChip(
                            title: "필터",
                            isActive: isFilter,
                            marginRight: 0,
                            leadingIcon:
                                Image.asset('assets/images/filter-icon.png'),
                            useLeadingIcon: true,
                            activeColor: Color(0xFFFFEB7C),
                            activeTxtColor: CatchmongColors.sub_gray,
                            onTap: onFilter,
                          ),
                          Row(
                            children: [
                              ...[
                                {
                                  "title": "인기순",
                                  "isActive": sortType == "favorite",
                                  "width": 80.0,
                                  "onTap": () => onSelectSort("favorite"),
                                },
                                {
                                  "title": "최신순",
                                  "isActive": sortType == "latest",
                                  "width": 80.0,
                                  "onTap": () => onSelectSort("latest"),
                                },
                                {
                                  "title": "리뷰순",
                                  "isActive": sortType == "review",
                                  "width": 80.0,
                                  "onTap": () => onSelectSort("review"),
                                },
                                {
                                  "title": "영업중",
                                  "isActive": timeType == "open",
                                  "width": 80.0,
                                  "onTap": () => onSelectBusinessTime("open"),
                                },
                                {
                                  "title": "24시간 영업",
                                  "isActive": timeType == "every",
                                  "width": 110.0,
                                  "onTap": () => onSelectBusinessTime("every"),
                                },
                                // {
                                //   "title": "예약",
                                //   "isActive": eatType == "reservation",
                                //   "width": 80.0,
                                //   "onTap": () => onSelectEatType("reservation"),
                                // },
                                // {
                                //   "title": "픽업",
                                //   "isActive": eatType == "pickup",
                                //   "width": 80.0,
                                //   "onTap": () => onSelectEatType("pickup"),
                                // },
                                ...[
                                  "고깃집",
                                  "찌개전문",
                                  "이자카야",
                                  "족발/보쌈",
                                  "레스토랑",
                                  "비건식당",
                                  "패스트푸드",
                                  "회/스시",
                                  "전집",
                                  "치킨",
                                  "한정식",
                                  "라멘",
                                  "중식",
                                  "분식",
                                  "디저트카페",
                                  "뷔페"
                                ].map((el) => {
                                      "title": el,
                                      "isActive": foodType == el,
                                      "width": 96.0,
                                      "onTap": () => onSelectFoodType(el),
                                    }),
                                {
                                  "title": "주차",
                                  "isActive": serviceType == "parking",
                                  "width": 90.0,
                                  "leadingIcon": Image.asset(
                                      'assets/images/parking-icon.png'),
                                  "onTap": () => onSelectServiceType("parking"),
                                },
                                {
                                  "title": "쿠폰",
                                  "isActive": serviceType == "coupon",
                                  "width": 90.0,
                                  "leadingIcon": Image.asset(
                                      'assets/images/coupon-icon.png'),
                                  "onTap": () => onSelectServiceType("coupon"),
                                },
                                {
                                  "title": "아기의자",
                                  "isActive": serviceType == "baby",
                                  "leadingIcon": Image.asset(
                                      'assets/images/baby-icon.png'),
                                  "width": 110.0,
                                  "onTap": () => onSelectServiceType("baby"),
                                },
                                {
                                  "title": "애견동반",
                                  "isActive": serviceType == "pet",
                                  "leadingIcon":
                                      Image.asset('assets/images/pet-icon.png'),
                                  "width": 110.0,
                                  "onTap": () => onSelectServiceType("pet"),
                                },
                              ].toList()
                                ..sort((a, b) => b["isActive"]
                                    .toString()
                                    .compareTo(a["isActive"].toString())),
                              // `isActive`가 true인 항목을 리스트 앞쪽으로 정렬
                            ]
                                .map(
                                  (item) => SizedBox(
                                    width: item["width"] as double,
                                    child: MapChip(
                                      title: item["title"] as String,
                                      isActive: isFilter
                                          ? item["isActive"] as bool
                                          : false,
                                      marginRight: 0,
                                      leadingIcon:
                                          item["leadingIcon"] as Widget? ??
                                              Container(),
                                      useLeadingIcon:
                                          item.containsKey("leadingIcon"),
                                      onTap: item["onTap"] as void Function(),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),

                if (!isMini)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "필터",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: CatchmongColors.gray_800,
                        ),
                      ),
                      InkWell(
                        onTap: onInit,
                        child: const Text(
                          "초기화",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: CatchmongColors.gray400,
                          ),
                        ),
                      ),
                    ],
                  ),
                if (!isMini) const SizedBox(height: 20),

                // 정렬 옵션
                if (!isMini)
                  const Text(
                    "정렬",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: CatchmongColors.sub_gray,
                    ),
                  ),
                if (!isMini) const SizedBox(height: 10),
                if (!isMini)
                  Wrap(
                    spacing: 4,
                    children: [
                      // _buildChip("인기순", true),
                      // _buildChip("최신순", false),
                      // _buildChip("리뷰순", false),
                      SizedBox(
                        width: 80,
                        child: MapChip(
                          title: "인기순",
                          isActive: sortType == "favorite",
                          marginRight: 0,
                          leadingIcon: Container(),
                          useLeadingIcon: false,
                          onTap: () {
                            onSelectSort("favorite");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: MapChip(
                          title: "최신순",
                          isActive: sortType == "latest",
                          marginRight: 0,
                          leadingIcon: Container(),
                          useLeadingIcon: false,
                          onTap: () {
                            onSelectSort("latest");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: MapChip(
                          title: "리뷰순",
                          isActive: sortType == "review",
                          marginRight: 0,
                          leadingIcon: Container(),
                          useLeadingIcon: false,
                          onTap: () {
                            onSelectSort("review");
                          },
                        ),
                      )
                    ],
                  ),
                if (!isMini) const SizedBox(height: 20),
                if (!isMini)
                  // 영업 시간 옵션
                  const Text(
                    "영업 시간",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: CatchmongColors.sub_gray,
                    ),
                  ),
                if (!isMini) const SizedBox(height: 10),
                if (!isMini)
                  Wrap(
                    spacing: 4,
                    children: [
                      SizedBox(
                        width: 80,
                        child: MapChip(
                          title: "영업중",
                          isActive: timeType == "open",
                          marginRight: 0,
                          leadingIcon: Container(),
                          useLeadingIcon: false,
                          onTap: () {
                            onSelectBusinessTime("open");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: MapChip(
                          title: "24시간 영업",
                          isActive: timeType == "every",
                          marginRight: 0,
                          leadingIcon: Container(),
                          useLeadingIcon: false,
                          onTap: () {
                            onSelectBusinessTime("every");
                          },
                        ),
                      ),
                    ],
                  ),
                if (!isMini) const SizedBox(height: 20),
                // if (!isMini)
                //   // 속성 옵션
                //   const Text(
                //     "속성",
                //     style: TextStyle(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w700,
                //       color: CatchmongColors.sub_gray,
                //     ),
                //   ),
                // if (!isMini) const SizedBox(height: 10),
                // if (!isMini)
                // Wrap(
                //   spacing: 4,
                //   children: [
                //     SizedBox(
                //       width: 80,
                //       child: MapChip(
                //         title: "예약",
                //         isActive: eatType == "reservation",
                //         marginRight: 0,
                //         leadingIcon: Container(),
                //         useLeadingIcon: false,
                //         onTap: () {
                //           onSelectEatType("reservation");
                //         },
                //       ),
                //     ),
                //     SizedBox(
                //       width: 80,
                //       child: MapChip(
                //         title: "픽업",
                //         isActive: eatType == "pickup",
                //         marginRight: 0,
                //         leadingIcon: Container(),
                //         useLeadingIcon: false,
                //         onTap: () {
                //           onSelectEatType("pickup");
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // if (!isMini) const SizedBox(height: 20),
                if (!isMini)
                  // 음식 종류 옵션
                  const Text(
                    "음식 종류",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                if (!isMini) const SizedBox(height: 10),
                if (!isMini)
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      ...[
                        "고깃집",
                        "찌개전문",
                        "이자카야",
                        "족발/보쌈",
                        "레스토랑",
                        "비건식당",
                        "패스트푸드",
                        "회/스시",
                        "전집",
                        "치킨",
                        "한정식",
                        "라멘",
                        "중식",
                        "분식",
                        "디저트카페",
                        "뷔페"
                      ].map(
                        (el) => Container(
                          // constraints:
                          // BoxConstraints(minWidth: 60, maxWidth: 100),
                          width: 96,
                          child: MapChip(
                            title: el,
                            isActive: foodType == el,
                            marginRight: 0,
                            leadingIcon: Container(),
                            useLeadingIcon: false,
                            onTap: () {
                              onSelectFoodType(el);
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                if (!isMini) const SizedBox(height: 20),
                if (!isMini)
                  // 서비스 옵션
                  const Text(
                    "서비스",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                if (!isMini) const SizedBox(height: 10),
                if (!isMini)
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      SizedBox(
                        width: 90,
                        child: MapChip(
                          title: "주차",
                          isActive: serviceType == "parking",
                          marginRight: 0,
                          leadingIcon:
                              Image.asset('assets/images/parking-icon.png'),
                          useLeadingIcon: true,
                          onTap: () {
                            onSelectServiceType("parking");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 90,
                        child: MapChip(
                          title: "쿠폰",
                          isActive: serviceType == "coupon",
                          marginRight: 0,
                          leadingIcon:
                              Image.asset('assets/images/coupon-icon.png'),
                          useLeadingIcon: true,
                          onTap: () {
                            onSelectServiceType("coupon");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: MapChip(
                          title: "아기의자",
                          isActive: serviceType == "baby",
                          marginRight: 0,
                          leadingIcon:
                              Image.asset('assets/images/baby-icon.png'),
                          useLeadingIcon: true,
                          onTap: () {
                            onSelectServiceType("baby");
                          },
                        ),
                      ),
                      SizedBox(
                        width: 110,
                        child: MapChip(
                          title: "애견동반",
                          isActive: serviceType == "pet",
                          marginRight: 0,
                          leadingIcon:
                              Image.asset('assets/images/pet-icon.png'),
                          useLeadingIcon: true,
                          onTap: () {
                            onSelectServiceType("pet");
                          },
                        ),
                      ),
                    ],
                  ),
                if (!isMini) const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        // 선택 상태 변경 로직
      },
      selectedColor: Colors.purple,
      backgroundColor: Colors.grey[200],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black,
      ),
    );
  }
}
