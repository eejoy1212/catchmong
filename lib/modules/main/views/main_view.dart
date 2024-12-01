import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/modules/mypage/views/mypage_view.dart';
import 'package:catchmong/widget/bar/mainview_appbar.dart';
import 'package:catchmong/widget/bar/map_appbar.dart';
import 'package:catchmong/widget/bar/mypage_appbar.dart';
import 'package:catchmong/widget/bar/qr_appbar.dart';
import 'package:catchmong/widget/bar/search_appbar.dart';
import 'package:catchmong/widget/card/MainCard.dart';
import 'package:catchmong/widget/card/ReviewCard.dart';
import 'package:catchmong/widget/card/hot-type-card.dart';
import 'package:catchmong/widget/card/restaurant-type-card.dart';
import 'package:catchmong/widget/chip/page-indicator.dart';
import 'package:catchmong/widget/content/map_content.dart';
import 'package:catchmong/widget/content/partner_content.dart';
import 'package:catchmong/widget/content/qr_camera_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  final List<Widget> _pages = [
    MainView(),
    PartnerContent(),
    MapContent(),
    QrCameraContent(),
    MyPageView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: bottomNavController.selectedIndex.value,
            children: _pages,
          ),
          appBar: _getAppBar(bottomNavController.selectedIndex.value),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: CatchmongColors.gray400,
            currentIndex: bottomNavController.selectedIndex.value,
            onTap: bottomNavController.onItemTapped,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/bottom-home.png'),
                label: '홈',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/bottom-search.png'),
                label: '검색',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/bottom-pin.png'),
                label: '지도',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/bottom-payback.png'),
                label: '페이백',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/images/bottom-my.png'),
                label: '마이페이지',
              ),
            ],
          ),
        ));
  }

  PreferredSizeWidget _getAppBar(int index) {
    final List<PreferredSizeWidget> appbars = [
      MainViewAppbar(),
      SearchAppbar(),
      MapAppbar(),
      QrAppbar(),
      MypageAppbar(),
    ];
    return appbars[index];
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 260, // 카드의 높이와 동일하게 설정
                color: CatchmongColors.gray50,
                child: Center(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal, // 가로로 스크롤되도록 설정
                    itemCount: 5, // 카드의 개수
                    itemBuilder: (context, index) {
                      return Image.asset(
                        "assets/images/main-banner${index + 1}.png",
                        width: MediaQuery.of(context).size.width,
                      ); // ReviewCard를 리스트에 삽입
                    },
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        5,
                        (index) => PageIndicator(
                            isCurrent: index == 1 ? true : false)),
                  ),
                ),
              )
            ]),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Column(
                          children: [
                            Image.asset('assets/images/partner.png'),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "파트너",
                              style: TextStyle(
                                  color: CatchmongColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                        // Expanded(child: Column(
                        //   children: [
                        //     Image.asset('assets/images/store.png'),
                        //      SizedBox(
                        //       height: 7,
                        //     ),
                        //     Text("스토어")
                        //   ],
                        // )),
                        Expanded(
                            child: Column(
                          children: [
                            Image.asset('assets/images/payback.png'),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "페이백",
                              style: TextStyle(
                                  color: CatchmongColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                        Expanded(
                            child: Column(
                          children: [
                            Image.asset('assets/images/register-store.png'),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "입점신청",
                              style: TextStyle(
                                  color: CatchmongColors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            //어떤식당을 찾으시나요 카드
            RestaurantTypeCard(),
            SizedBox(
              height: 12,
            ),
            HotTypeCard(),
            SizedBox(
              height: 12,
            ),
            // 리뷰몽
            MainCard(
              minWidth: 320,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "인기 맛집 리뷰몽",
                      style: TextStyle(
                          color: CatchmongColors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "직접 먹어 봤어요! 리얼 리뷰!",
                      style: TextStyle(
                          color: CatchmongColors.sub_gray,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    SizedBox(
                      height: 436, // 카드의 높이와 동일하게 설정
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal, // 가로로 스크롤되도록 설정
                        itemCount: 5, // 카드의 개수
                        itemBuilder: (context, index) {
                          return ReviewCard(); // ReviewCard를 리스트에 삽입
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            //스토어
            // MainCard(
            //   minWidth: 320,
            //   child: Container(
            //     margin: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         Row(
            //           crossAxisAlignment: CrossAxisAlignment.center,
            //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //           children: [
            //             Column(
            //               mainAxisAlignment: MainAxisAlignment.start,
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 Text(
            //                   "스토어 상품",
            //                   style: TextStyle(
            //                       color: CatchmongColors.black,
            //                       fontWeight: FontWeight.w600,
            //                       fontSize: 16),
            //                 ),
            //                 SizedBox(
            //                   height: 4,
            //                 ),
            //                 Text(
            //                   "구매하고 페이백 받아 보세요!",
            //                   style: TextStyle(
            //                       color: CatchmongColors.sub_gray,
            //                       fontWeight: FontWeight.w500,
            //                       fontSize: 14),
            //                 ),
            //               ],
            //             ),
            //             InkWell(
            //               onTap: () {
            //                 print("더보기");
            //               },
            //               child: Text(
            //                 "더보기",
            //                 style: TextStyle(
            //                     color: CatchmongColors.gray400,
            //                     fontSize: 14,
            //                     fontWeight: FontWeight.w700),
            //               ),
            //             )
            //           ],
            //         ),
            //         SizedBox(
            //           height: 16,
            //         ),
            //         // SizedBox(
            //         //   height: 550,
            //         //   child: GridView.builder(
            //         //     physics: NeverScrollableScrollPhysics(),
            //         //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         //       crossAxisCount: 2, // 한 줄에 두 개의 아이템을 배치
            //         //       mainAxisSpacing: 20, // 세로 간격
            //         //       crossAxisSpacing: 16, // 가로 간격
            //         //       childAspectRatio:
            //         //           0.6, // 카드의 가로세로 비율 조정 (카드의 높이를 늘리기 위해 비율 설정)
            //         //     ),
            //         //     itemCount: 4, // 카드의 개수
            //         //     itemBuilder: (context, index) {
            //         //       return IntrinsicHeight(
            //         //           child: StoreGiftCard()); // 각 그리드 셀에 들어갈 카드 컴포넌트
            //         //     },
            //         //   ),
            //         // )
            //         Column(
            //           children: [
            //             Row(
            //               children: [
            //                 Expanded(child: StoreGiftCard()),
            //                 SizedBox(
            //                   width: 8,
            //                 ),
            //                 Expanded(child: StoreGiftCard()),
            //               ],
            //             ),
            //             SizedBox(
            //               height: 20,
            //             ),
            //             Row(
            //               children: [
            //                 Expanded(child: StoreGiftCard()),
            //                 SizedBox(
            //                   width: 8,
            //                 ),
            //                 Expanded(child: StoreGiftCard()),
            //               ],
            //             ),
            //           ],
            //         )
            //       ],
            //     ),
            //   ),
            // ),

            // SizedBox(
            //   height: 16,
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120, // 카드의 높이와 동일하게 설정
              child: ListView.builder(
                scrollDirection: Axis.horizontal, // 가로로 스크롤되도록 설정
                itemCount: 2, // 카드의 개수
                itemBuilder: (context, index) {
                  return Image.asset(
                    "assets/images/banner${index + 1}.png",
                    width: MediaQuery.of(context).size.width,
                  ); // ReviewCard를 리스트에 삽입
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
