import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/controller/review_controller.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/modules/mypage/views/mypage_view.dart';
import 'package:catchmong/modules/partner/views/partner-show-view.dart';
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
import 'package:catchmong/widget/content/payback_content.dart';
import 'package:catchmong/widget/content/qr_camera_content.dart';
import 'package:catchmong/widget/content/scrap_partner_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  final BottomNavController bottomNavController =
      Get.find<BottomNavController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      int currentIndex = bottomNavController.selectedIndex.value;
      return Scaffold(
        floatingActionButtonAnimator: FloatingActionButtonAnimator.noAnimation,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        bottomSheet: currentIndex == 2
            ? InkWell(
                onTap: () {
                  showQrScanner(context);
                },
                child: Container(
                    // padding: EdgeInsets.only(bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 48,
                    decoration: BoxDecoration(
                        color: CatchmongColors.yellow_main,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8))),
                    child: Center(
                        child: Text(
                      "결제하고 돌려받기",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ))),
              )
            : null,
        appBar: _getAppBar(currentIndex), // 선택된 인덱스에 따라 AppBar 변경
        body: _getBody(currentIndex), // 선택된 인덱스에 따라 Body 변경
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedItemColor: CatchmongColors.black,
          currentIndex: currentIndex,
          onTap: bottomNavController.onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/bottom-home.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 0
                      ? CatchmongColors.black
                      : CatchmongColors.gray400,
                  BlendMode.srcIn,
                ),
              ),
              label: '홈',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/bottom-search.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 1
                      ? CatchmongColors.black
                      : CatchmongColors.gray400,
                  BlendMode.srcIn,
                ),
              ),
              label: '검색',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/bottom-payback.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 2
                      ? CatchmongColors.black
                      : CatchmongColors.gray400,
                  BlendMode.srcIn,
                ),
              ),
              label: '페이백',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/bottom-pin.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 3
                      ? CatchmongColors.black
                      : CatchmongColors.gray400,
                  BlendMode.srcIn,
                ),
              ),
              label: '지도',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/bottom-my.svg',
                colorFilter: ColorFilter.mode(
                  currentIndex == 4
                      ? CatchmongColors.black
                      : CatchmongColors.gray400,
                  BlendMode.srcIn,
                ),
              ),
              label: '마이페이지',
            ),
          ],
        ),
      );
    });
  }

  // 선택된 페이지 반환
  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return MainView();
      case 1:
        return PartnerContent();
      case 2:
        return PaybackContent(); //QrCameraContent();
      case 3:
        return MapContent();
      case 4:
        return MyPageView();
      default:
        return MainView();
    }
  }

  // 선택된 AppBar 반환
  PreferredSizeWidget _getAppBar(int index) {
    // final BottomNavController bottomNavController =
    //     Get.find<BottomNavController>();

    // if (index == 3) {
    //   // 지도 탭 처리
    //   return Obx(() {
    //     return bottomNavController.isShowingPartner.value
    //         ? ScrapPartnerContent() // PartnerShowView 화면
    //         : MapAppbar(); // 기본 MapContent 화면
    //   });
    // }
    switch (index) {
      case 0:
        return MainViewAppbar();
      case 1:
        return SearchAppbar();
      case 2:
        return QrAppbar();
      case 3:
        return MapAppbar();
      case 4:
        return MypageAppbar();

      default:
        return MainViewAppbar();
    }
  }
}

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PageController _pageController =
        PageController(); // PageController 추가
    final ReviewController controller = Get.find<ReviewController>();
    final Partner2Controller partnerController = Get.find<Partner2Controller>();
    final LoginController loginController = Get.find<LoginController>();
    final BottomNavController bottomNavController =
        Get.find<BottomNavController>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(children: [
              SizedBox(
                height: 260, // 카드 높이
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 5, // 배너 개수
                  onPageChanged: (index) {
                    // 배너 인덱스 변경 시 업데이트
                    controller.bannerIdx.value = index;
                  },
                  itemBuilder: (context, index) {
                    return Image.asset(
                      "assets/images/main-banner${index + 1}.png",
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    );
                  },
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
                        (index) => Obx(() => PageIndicator(
                            isCurrent: index == controller.bannerIdx.value
                                ? true
                                : false))),
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
                            InkWell(
                                onTap: () {
                                  bottomNavController.selectedIndex.value = 1;
                                },
                                child: SvgPicture.asset(
                                    'assets/images/partner.svg')),
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
                            InkWell(
                                onTap: () {
                                  bottomNavController.selectedIndex.value = 2;
                                },
                                child: SvgPicture.asset(
                                    'assets/images/payback.svg')),
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
                            InkWell(
                                onTap: () {
                                  showMyStore(context);
                                },
                                child: SvgPicture.asset(
                                    'assets/images/signin.svg')),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "가입신청",
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
                        itemCount: controller.favoriteReviews.length, // 카드의 개수
                        itemBuilder: (context, index) {
                          final review = controller.favoriteReviews[index];
                          final partner = review.partner!;
                          final businessStatus =
                              partnerController.getBusinessStatus(
                            partner.businessTime ?? "",
                            partner.breakTime,
                            partner.regularHoliday,
                          );
                          final rating = partnerController.getRating(partner);
                          final replyCount = partnerController
                              .getReplyCount(partner.reviews?.length ?? 0);
                          bool isScraped = loginController
                                  .user.value!.scrapPartners
                                  .firstWhereOrNull(
                                      (el) => el.id == partner.id) !=
                              null;
                          return InkWell(
                            onTap: () {
                              partnerController.showSelectedPartner(context,
                                  partner, businessStatus, rating, replyCount);
                            },
                            child: ReviewCard(
                              review: review,
                              isScraped: isScraped,
                            ),
                          ); // ReviewCard를 리스트에 삽입
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

void showQrScanner(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return QrCameraContent();
    },
  );
}
