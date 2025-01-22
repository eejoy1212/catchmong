import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/controller/reservation_controller.dart';
import 'package:catchmong/model/menu.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/widget/bar/default_appbar.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/button/alert-btn.dart';
import 'package:catchmong/widget/button/location-copy-btn.dart';
import 'package:catchmong/widget/button/more-btn.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:catchmong/widget/button/phone-call-btn.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/card/partner-review-card.dart';
import 'package:catchmong/widget/card/reservation_card.dart';
import 'package:catchmong/widget/chip/menu_chip.dart';
import 'package:catchmong/widget/chip/partner-content-chip.dart';
import 'package:catchmong/widget/status/star_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PartnerShowView extends StatelessWidget {
  final Partner partner;
  final String businessStatus;
  final double rating;
  final String replyCount;
  const PartnerShowView(
      {super.key,
      required this.partner,
      required this.businessStatus,
      required this.rating,
      required this.replyCount});

  @override
  Widget build(BuildContext context) {
    Map<String, String> _getCategoryPriceRange(List<Menu> menus) {
      // NumberFormat for formatting prices with comma
      final formatter = NumberFormat('#,###');

      // Map to store the price range for each category
      Map<String, List<double>> categoryPrices = {};

      for (var menu in menus) {
        // Ensure the category is valid
        String category = menu.category;

        // Add price to the corresponding category
        if (!categoryPrices.containsKey(category)) {
          categoryPrices[category] = [];
        }
        if (menu.price != null) {
          categoryPrices[category]?.add(menu.price!);
        }
      }

      // Compute the price range for each category
      Map<String, String> priceRanges = categoryPrices.map((category, prices) {
        double minPrice = prices.reduce((a, b) => a < b ? a : b);
        double maxPrice = prices.reduce((a, b) => a > b ? a : b);
        return MapEntry(
          category,
          "${formatter.format(minPrice)}원 - ${formatter.format(maxPrice)}원",
        );
      });

      return priceRanges;
    }

    List<String> _getMenuCategories(List<Menu> menus) {
      // `menus`에서 중복되지 않은 카테고리 리스트 추출
      return menus
          .map((menu) => menu.category) // 카테고리가 없으면 "미분류"로 설정
          .toSet() // 중복 제거
          .toList(); // 리스트로 변환
    }

    String _getBusiness(Partner partner) {
      // 휴무일 정보
      final holiday = partner.regularHoliday;
      // 영업시간 정보
      final businessTime = partner.businessTime ?? "영업 시간 정보 없음";

      // 요일 목록
      final days = ["월", "화", "수", "목", "금", "토", "일"];
      // 휴무일이 있는 경우 해당 요일 제거
      final openDays =
          holiday != null ? days.where((day) => day != holiday).toList() : days;

      // 요일과 영업시간 결합
      final result = openDays.map((day) => "$day $businessTime").join("\n");

      return result;
    }

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

    String _formatPrice(String? price) {
      print("price in format>>>${price}");
      if (price == null) return "-";

      // `tryParse`로 문자열을 정수로 변환
      double parsedPrice = double.tryParse(price) ?? 0;
      // int? parsedPrice = int.tryParse(price);
      if (parsedPrice == null) return "-";

      // 천단위 콤마 추가
      final formatter = NumberFormat('#,###');
      return formatter.format(parsedPrice) + "원";
    }

    bool isLocal = partner.storePhotos != null &&
        partner.storePhotos!.where((el) => el.contains("uploads")).isEmpty;
    bool getIsLocal(int index) {
      if (partner.storePhotos != null &&
          partner.storePhotos!.length > index &&
          partner.storePhotos![index].contains("uploads")) {
        return true;
      } else {
        return false;
      }
    }

    bool _isLocal(String imagePath) {
      return !imagePath.contains("uploads");
    }

    final ReservationConteroller conteroller =
        Get.find<ReservationConteroller>();
    return Scaffold(
      appBar: AppBar(
        leading: AppbarBackBtn(),
        actions: [
          InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                              opacity: 0,
                              child:
                                  Image.asset('assets/images/close-icon.png')),
                          Text(
                            "공유하기",
                            style: TextStyle(
                              color: CatchmongColors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child:
                                  Image.asset('assets/images/close-icon.png'))
                        ],
                      ),
                      content: SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/kakao-share.png'),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "카카오로\n공유하기",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_800,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 32,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/link-share.png'),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "링크로\n공유하기",
                                  style: TextStyle(
                                    color: CatchmongColors.gray_800,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: Icon(
                Icons.file_upload_outlined,
                color: CatchmongColors.black,
                // size: 20,
              )),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //이미지 그리드
            Row(
              children: [
                Expanded(
                  child: Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CatchmongColors.gray, width: 1), // 외부 테두리
                      ),
                      child: ImgCard(
                          isLocal: partner.storePhotos != null &&
                              partner.storePhotos!.length > 0 &&
                              _isLocal(partner.storePhotos![0]),
                          path: partner.storePhotos?.isNotEmpty == true &&
                                  partner.storePhotos!.length > 0
                              ? (_isLocal(partner.storePhotos![0])
                                  ? partner.storePhotos![0]
                                  : 'http://$myPort:3000/${partner.storePhotos![0]}')
                              : '')),
                ),
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CatchmongColors.gray,
                                    width: 1), // 외부 테두리
                              ),
                              child: ImgCard(
                                  isLocal: partner.storePhotos != null &&
                                      partner.storePhotos!.length > 1 &&
                                      _isLocal(partner.storePhotos![1]),
                                  path: partner.storePhotos?.isNotEmpty ==
                                              true &&
                                          partner.storePhotos!.length > 1
                                      ? (_isLocal(partner.storePhotos![1])
                                          ? partner.storePhotos![1]
                                          : 'http://$myPort:3000/${partner.storePhotos![1]}')
                                      : ''),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CatchmongColors.gray,
                                    width: 1), // 외부 테두리
                              ),
                              child: ImgCard(
                                  isLocal: partner.storePhotos != null &&
                                      partner.storePhotos!.length > 2 &&
                                      _isLocal(partner.storePhotos![2]),
                                  path: partner.storePhotos?.isNotEmpty ==
                                              true &&
                                          partner.storePhotos!.length > 2
                                      ? (_isLocal(partner.storePhotos![2])
                                          ? partner.storePhotos![2]
                                          : 'http://$myPort:3000/${partner.storePhotos![2]}')
                                      : ''),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              width: 108,
                              height: 108,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: CatchmongColors.gray,
                                    width: 1), // 외부 테두리
                              ),
                              child: ImgCard(
                                  isLocal: partner.storePhotos != null &&
                                      partner.storePhotos!.length > 3 &&
                                      _isLocal(partner.storePhotos![3]),
                                  path: partner.storePhotos?.isNotEmpty ==
                                              true &&
                                          partner.storePhotos!.length > 3
                                      ? (_isLocal(partner.storePhotos![3])
                                          ? partner.storePhotos![3]
                                          : 'http://$myPort:3000/${partner.storePhotos![3]}')
                                      : ''),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Stack(children: [
                              Container(
                                width: 108,
                                height: 108,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: CatchmongColors.gray,
                                      width: 1), // 외부 테두리
                                ),
                                child: ImgCard(
                                    isLocal: partner.storePhotos != null &&
                                        partner.storePhotos!.length > 4 &&
                                        _isLocal(partner.storePhotos![4]),
                                    path: partner.storePhotos?.isNotEmpty ==
                                                true &&
                                            partner.storePhotos!.length > 4
                                        ? (_isLocal(partner.storePhotos![4])
                                            ? partner.storePhotos![4]
                                            : 'http://$myPort:3000/${partner.storePhotos![4]}')
                                        : ''),
                              ),
                              if (partner.storePhotos != null &&
                                  partner.storePhotos!.length > 5)
                                Positioned.fill(
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                                'assets/images/img-icon.png'),
                                            Text(
                                              "999+",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ]),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
            //정보
            //가게명
            ,
            //알림받기 컨테이너
            Container(
              margin: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 12,
              ),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: CatchmongColors.gray50,
              ))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        constraints: BoxConstraints(
                          maxWidth: 130,
                        ),
                        child: Text(
                          partner.name,
                          maxLines: 3,
                          style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: CatchmongColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      StarStatus(
                        rating: rating,
                      ),
                      Spacer(),
                      //pin 뱃지
                      AlertBtn(),
                      SizedBox(
                        width: 8,
                      ),
                      SvgPicture.asset('assets/partners/active-pin.svg'),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        businessStatus,
                        style: TextStyle(
                          color: businessStatus == "영업중"
                              ? Colors.green
                              : businessStatus == "브레이크타임"
                                  ? Colors.orange
                                  : Colors.red,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "•",
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      Text(
                        partner.category,
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "•",
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      Text(
                        replyCount,
                        style: TextStyle(
                          fontSize: 14,
                          color: CatchmongColors.sub_gray,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //가게소개 카드
            Container(
              margin: EdgeInsets.only(
                top: 12,
                bottom: 12,
              ),
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 12,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //주소복사
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/icons/map-marker-icon.svg'),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          partner.address,
                          softWrap: true, // 텍스트 줄바꿈 설정
                          overflow: TextOverflow.ellipsis, // 넘치는 텍스트를 잘라내기 설정
                          maxLines: 3, // 최대 줄 수 설정 (필요 시)
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      LocationCopyBtn()
                    ],
                  )
                  //전화번호
                  ,
                  SizedBox(
                    height: 12,
                  ),
                  PhoneCallBtn(
                    phoneNumber: partner.phone,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  //시간
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/clock-icon.svg'),
                      SizedBox(
                        width: 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            partner.hasHoliday
                                ? "${partner.regularHoliday} 휴무"
                                : "매일 영업",
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            _getBusiness(partner),
                            style: TextStyle(
                              color: CatchmongColors.sub_gray,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                  //가게소개문구
                  ,
                  SizedBox(
                    height: 12,
                  ),
                  //가게 소개 문구
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/heart-icon.svg'),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partner.description ?? "-",
                              style: TextStyle(
                                color: CatchmongColors.sub_gray,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal, // 가로 스크롤 활성화
                              child: Row(
                                mainAxisSize:
                                    MainAxisSize.min, // Row의 크기를 자식 크기에 맞게 설정
                                children: List.generate(
                                    partner.amenities == null
                                        ? 0
                                        : partner.amenities!.length,
                                    (int index) {
                                  String amenityFileName =
                                      _getAmenity(partner.amenities![index]);
                                  return PartnerContentChip(
                                    title: partner.amenities![index],
                                    image: Image.asset(
                                        'assets/images/$amenityFileName-icon.png'),
                                  );
                                }),
                                // [

                                // PartnerContentChip(
                                //   title: "아기의자",
                                //   image: Image.asset(
                                //       'assets/images/baby-icon.png'),
                                // ),
                                //   SizedBox(width: 8), // 간격 추가
                                //   PartnerContentChip(
                                //     title: "쿠폰",
                                //     image: Image.asset(
                                //         'assets/images/coupon-icon.png'),
                                //   ),
                                //   SizedBox(width: 8), // 간격 추가
                                //   PartnerContentChip(
                                //     title: "주차",
                                //     image: Image.asset(
                                //         'assets/images/parking-icon.png'),
                                //   ),
                                //   SizedBox(width: 8), // 간격 추가
                                //   PartnerContentChip(
                                //     title: "애견동반",
                                //     image: Image.asset(
                                //         'assets/images/pet-icon.png'),
                                //   ),
                                // ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                  //리뷰 카드
                  ,
                ],
              ),
            ),
            Container(
                width: double.infinity,
                margin: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                child: OutlinedBtn(
                    title: "예약하기",
                    onPress: () async {
                      //파트너 아이디 넘기기
                      // Get.toNamed("/reservation", parameters: {"partner": "2"});
                      if (partner.id == null) return;

                      await conteroller.fetchReservationSettings(partner.id!);
                      //full size 다이얼로그
                      showGeneralDialog(
                        context: context,
                        barrierDismissible:
                            true, // true로 설정했으므로 barrierLabel 필요
                        barrierLabel: "닫기", // 접근성 레이블 설정
                        barrierColor: Colors.black54, // 배경 색상
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return Scaffold(
                            backgroundColor: Colors.white,
                            appBar: DefaultAppbar(title: "예약"),
                            body: SafeArea(
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                  'assets/images/file-edit-icon.svg'),
                                              Text(
                                                "신청 후 확정 매장",
                                                style: TextStyle(
                                                  color:
                                                      CatchmongColors.gray_800,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "업체에서 확인 후 예약을 확정합니다.",
                                            style: TextStyle(
                                              color: CatchmongColors.gray_800,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap:
                                          true, // 부모 위젯의 높이를 넘어가지 않도록 설정
                                      physics:
                                          NeverScrollableScrollPhysics(), // 스크롤 비활성화 (필요시)
                                      itemCount: conteroller.reservationSettings
                                          .length, // 아이템 개수 설정
                                      itemBuilder: (context, index) {
                                        final setting = conteroller
                                            .reservationSettings[index];
                                        return Container(
                                          margin: EdgeInsets.only(
                                              bottom: 12), // 각 아이템의 간격 추가
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                  color:
                                                      CatchmongColors.gray50),
                                            ),
                                          ),
                                          child: ReservationCard(
                                            setting: setting,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    })),
            Divider(
              color: CatchmongColors.gray50,
            ),
            Container(
              color: Colors.white,
              child: DefaultTabController(
                length: 2, // 탭 개수: 메뉴와 리뷰
                child: Column(
                  children: [
                    // 탭바
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                        color: CatchmongColors.gray50,
                      ))),
                      child: TabBar(
                        indicatorColor: CatchmongColors.gray_800,
                        labelColor: CatchmongColors.gray_800,
                        tabs: [
                          Tab(text: "메뉴"),
                          Tab(text: "리뷰"),
                        ],
                      ),
                    ),
                    // 탭바 뷰
                    Container(
                      height: 700, // 탭 뷰 높이 설정

                      child: TabBarView(
                        children: [
                          // 메뉴 탭 내용
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                //칩
                                Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 12,
                                      horizontal: 20), // 위아래 여백 추가
                                  child: SizedBox(
                                    height: 36, // ListView 높이 설정 (칩의 높이만큼 설정)
                                    child: ListView.builder(
                                      scrollDirection:
                                          Axis.horizontal, // 가로 스크롤 설정
                                      itemCount: partner.menus == null
                                          ? 0
                                          : _getMenuCategories(partner.menus!)
                                              .length, // 칩의 개수
                                      itemBuilder: (context, index) {
                                        String getTitle() {
                                          switch (index) {
                                            case 0:
                                              return "에피타이저";
                                            case 1:
                                              return "메인 메뉴";
                                            case 2:
                                              return "사이드";
                                            case 3:
                                              return "음료&주류";
                                            default:
                                              return "";
                                          }
                                        }

                                        return InkWell(
                                          child: Container(
                                              margin: EdgeInsets.only(right: 8),
                                              child:
                                                  MenuChip(title: getTitle())),
                                        );
                                      },
                                    ),
                                  ),
                                ),

                                if (partner.menus == null)
                                  Container(
                                    height: 550,
                                    child: Center(child: Text("메뉴가 없습니다.")),
                                  )
                                else
                                  ...List.generate(partner.menus!.length,
                                      (int index) {
                                    Map<String, String> priceRanges =
                                        _getCategoryPriceRange(partner.menus!);

                                    priceRanges.forEach((category, range) {
                                      print(">>>!!$category: $range");
                                    });
                                    return Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                partner.menus![index].category,
                                                style: TextStyle(
                                                  color:
                                                      CatchmongColors.gray_800,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              Text(
                                                priceRanges[partner
                                                        .menus![index]
                                                        .category] ??
                                                    "-",
                                                style: TextStyle(
                                                  color:
                                                      CatchmongColors.gray400,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        //메뉴 카드
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                            color: CatchmongColors.gray50,
                                          ))),
                                          padding: EdgeInsets.only(
                                            left: 20,
                                            top: 16,
                                            right: 20,
                                            bottom: 32,
                                          ),
                                          child: Row(
                                            children: [
                                              //이미지
                                              Container(
                                                width: 100,
                                                height: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8)),
                                                  border: Border.all(
                                                    color:
                                                        CatchmongColors.gray50,
                                                    width: 1,
                                                  ), // 외부 테두리
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8), // 이미지를 둥글게 자르기
                                                  child: ImgCard(
                                                      isLocal: _isLocal(partner
                                                              .menus?[index]
                                                              .image ??
                                                          ""),
                                                      path: _isLocal(partner
                                                                  .menus?[index]
                                                                  .image ??
                                                              "")
                                                          ? "${partner.menus?[index].image}"
                                                          : 'http://$myPort:3000/${partner.menus?[index].image}'),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 8,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    partner.menus![index].name,
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    "${_formatPrice(partner.menus?[index].price.toString())}",
                                                    style: TextStyle(
                                                      color:
                                                          CatchmongColors.black,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  })
                              ],
                            ),
                          ),
                          // 리뷰 탭 내용
                          partner.reviews == null
                              ? Container(
                                  height: 200,
                                  child: Center(
                                    child: Text("리뷰가 없습니다."),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: partner.reviews!.length,
                                  itemBuilder: (context, index) {
                                    return PartnerReviewCard(
                                      review: partner.reviews![index],
                                    );
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
