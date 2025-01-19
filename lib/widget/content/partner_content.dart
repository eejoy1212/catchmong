import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/controller/partner_controller.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/model/review.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/widget/bar/CatchmongSearchBar.dart';
import 'package:catchmong/widget/card/img_card.dart';
import 'package:catchmong/widget/card/scrap_partner_card.dart';
import 'package:catchmong/widget/chip/TagChip.dart';
import 'package:catchmong/widget/content/scrap_partner_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class PartnerContent extends StatelessWidget {
  const PartnerContent({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final LoginController loginController = Get.find<LoginController>();
    final Partner2Controller partnerController = Get.find<Partner2Controller>();
    print(
        "유저의 현재 위치: ${loginController.user.value?.regionId}"); //이게 null이면 모든지역 인거임.
    // bool isAllRegion = loginController.user.value?.regionId == null;
    partnerController.fetchPartnersByIds();
    partnerController.fetchFavoritePartners();
    List<Partner> displayedRecent = partnerController.recentPartners.length > 5
        ? partnerController.recentPartners.sublist(0, 5)
        : partnerController.recentPartners;
    List<Partner> displayedFav = partnerController.favoritePartners.length > 5
        ? partnerController.favoritePartners.sublist(0, 5)
        : partnerController.favoritePartners;

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              // margin: EdgeInsets.only(left: 20, right: 20, top: 16),
              // height: height, // 테스트용 길이
              child: Column(
                children: [
                  //검색창
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(() => CatchmongSearchBar(
                                isResult: partnerController
                                    .searchKeyword.value.isNotEmpty,
                                searchKeyword:
                                    partnerController.searchKeyword.value,
                                onSubmitted: (String value) {
                                  partnerController.searchKeyword.value = value;
                                  partnerController.fetchPartnersByKeyword();
                                  partnerController.addSearchTerm(value);
                                  partnerController.fetchPartnersByIds();
                                },
                                onClear: () {
                                  partnerController.searchKeyword.value = "";
                                  partnerController.partners.clear();
                                },
                                onChanged: (String value) {},
                              )),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Obx(() => partnerController
                                .searchKeyword.value.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  partnerController.searchKeyword.value = "";
                                  partnerController.partners.clear();
                                },
                                child: SvgPicture.asset(
                                    'assets/icons/home-icon.svg'))
                            : Container()),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  //  검색창에 검색어 있으면 검색화면, 아니면 최근 검색어, 최근 본 매장
                  //partnerController.partners의 길이만큼 ScrapPartnerContent를 만들어주세요
                  Obx(() => partnerController.searchKeyword.isEmpty
                      // partnerController.searchKeyword.value.trim() == ""
                      ? Column(
                          children: [
                            //최근 검색어
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "최근 검색어",
                                        style: TextStyle(
                                            color: CatchmongColors.gray_800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          partnerController
                                              .removeAllSearchTerm();
                                        },
                                        child: Text(
                                          "전체삭제",
                                          style: TextStyle(
                                              color: CatchmongColors.gray400,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  )
                                  //세로로 스크롤되는 리스트 , 한 화면에 세개까지만 보이는 리스트로 만들어주 ㅓ
                                  // 세로 스크롤되는 리스트 (한 화면에 3개만 보이는 리스트)
                                  ,
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    height:
                                        100, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                                    child: ListView.builder(
                                      itemCount: partnerController
                                          .recentSearches
                                          .length, // 예시로 10개의 항목 생성

                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            partnerController
                                                    .searchKeyword.value =
                                                partnerController
                                                    .recentSearches[index];
                                            partnerController
                                                .fetchPartnersByKeyword();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 8),
                                            height: 28,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                  partnerController
                                                      .recentSearches[index],
                                                  style: const TextStyle(
                                                      color: CatchmongColors
                                                          .gray_800,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      partnerController
                                                          .removeSearchTerm(
                                                              partnerController
                                                                      .recentSearches[
                                                                  index]);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      size: 18,
                                                    ))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: CatchmongColors.gray50,
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            //최근 본 매장
                            Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "최근 본 매장",
                                        style: TextStyle(
                                            color: CatchmongColors.gray_800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          partnerController
                                              .searchKeyword.value = " ";
                                          partnerController.partners.clear();
                                          partnerController.partners.addAll(
                                              partnerController.recentPartners);
                                          print("최근 더보기 클릭");
                                        },
                                        child: Text(
                                          "더보기",
                                          style: TextStyle(
                                              color: CatchmongColors.gray400,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  )
                                  //세로로 스크롤되는 리스트 , 한 화면에 세개까지만 보이는 리스트로 만들어주 ㅓ
                                  // 세로 스크롤되는 리스트 (한 화면에 3개만 보이는 리스트)
                                  ,
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    height:
                                        203, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                                    child: partnerController
                                            .recentPartners.isEmpty
                                        ? Center(
                                            child: Text("최근 본 매장이 없습니다."),
                                          )
                                        : ListView.builder(
                                            itemCount: displayedRecent
                                                .length, // 예시로 10개의 항목 생성
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              Partner partner =
                                                  displayedRecent[index];
                                              final businessStatus =
                                                  partnerController
                                                      .getBusinessStatus(
                                                partner.businessTime ?? "",
                                                partner.breakTime,
                                                partner.regularHoliday,
                                              );
                                              final rating = partnerController
                                                  .getRating(partner);
                                              final replyCount =
                                                  partnerController
                                                      .getReplyCount(partner
                                                              .reviews
                                                              ?.length ??
                                                          0);
                                              return InkWell(
                                                onTap: () {
                                                  partnerController
                                                      .showSelectedPartner(
                                                          context,
                                                          partner,
                                                          businessStatus,
                                                          rating,
                                                          replyCount);
                                                },
                                                child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 16),
                                                    height: 192,
                                                    child: Column(
                                                      children: [
                                                        // 이미지
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8), // 둥근 모서리로 잘라줌
                                                          child: Container(
                                                            width: 108,
                                                            height: 132,
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color:
                                                                      CatchmongColors
                                                                          .gray,
                                                                  width:
                                                                      1), // 외부 테두리
                                                            ),
                                                            child: ImgCard(
                                                              path: 'http://$myPort:3000/' +
                                                                  partnerController
                                                                      .recentPartners[
                                                                          index]
                                                                      .storePhotos![0],
                                                            ),
                                                          ),
                                                        ),
                                                        //가게명
                                                        SizedBox(
                                                            height:
                                                                8), // 이미지와 텍스트 사이 간격
                                                        // 가게명
                                                        Container(
                                                          width:
                                                              108, // 부모 컨테이너의 너비를 지정
                                                          child: Text(
                                                            partnerController
                                                                .recentPartners[
                                                                    index]
                                                                .name,
                                                            maxLines:
                                                                3, // 최대 3줄까지 표시
                                                            overflow: TextOverflow
                                                                .ellipsis, // 글자가 넘치면 ... 처리
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  CatchmongColors
                                                                      .gray_800,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )),
                                              );
                                            },
                                          ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: CatchmongColors.gray50,
                            ), //인기 매장
                            Container(
                              margin: EdgeInsets.only(left: 20, right: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "인기 매장",
                                        style: TextStyle(
                                            color: CatchmongColors.gray_800,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          partnerController
                                              .searchKeyword.value = " ";
                                          partnerController.partners.clear();
                                          partnerController.partners.addAll(
                                              partnerController
                                                  .favoritePartners);
                                        },
                                        child: Text(
                                          "더보기",
                                          style: TextStyle(
                                              color: CatchmongColors.gray400,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  )
                                  //세로로 스크롤되는 리스트 , 한 화면에 세개까지만 보이는 리스트로 만들어주 ㅓ
                                  // 세로 스크롤되는 리스트 (한 화면에 3개만 보이는 리스트)
                                  ,
                                  SizedBox(
                                    height: 16,
                                  ),
                                  Container(
                                    height:
                                        270, // 리스트 높이: 48px * 3 (한 번에 3개 보이도록 설정)
                                    child: ListView.builder(
                                      itemCount:
                                          displayedFav.length, // 예시로 10개의 항목 생성

                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        Partner partner = displayedFav[index];
                                        final businessStatus =
                                            partnerController.getBusinessStatus(
                                          partner.businessTime ?? "",
                                          partner.breakTime,
                                          partner.regularHoliday,
                                        );
                                        final rating = partnerController
                                            .getRating(partner);
                                        final replyCount =
                                            partnerController.getReplyCount(
                                                partner.reviews?.length ?? 0);
                                        return InkWell(
                                          onTap: () {
                                            partnerController
                                                .showSelectedPartner(
                                                    context,
                                                    partner,
                                                    businessStatus,
                                                    rating,
                                                    replyCount);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                right: 16),
                                            child: Column(
                                              children: [
                                                // 이미지
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8), // 둥근 모서리로 잘라줌
                                                  child: Container(
                                                    width: 150,
                                                    height: 180,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: CatchmongColors
                                                              .gray,
                                                          width: 1), // 외부 테두리
                                                    ),
                                                    child: ImgCard(
                                                      path: 'http://$myPort:3000/' +
                                                          partnerController
                                                              .favoritePartners[
                                                                  index]
                                                              .storePhotos![0],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                // 가게명
                                                SizedBox(
                                                  width: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            partnerController
                                                                .favoritePartners[
                                                                    index]
                                                                .name,
                                                            style: TextStyle(
                                                                color:
                                                                    CatchmongColors
                                                                        .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14),
                                                          ),
                                                          SizedBox(
                                                            height: 1,
                                                          ),
                                                          Row(
                                                            children: [
                                                              SvgPicture.asset(
                                                                  'assets/images/review-star.svg'),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                partnerController
                                                                    .getAverageRating(partnerController
                                                                        .favoritePartners[
                                                                            index]
                                                                        .reviews)
                                                                    .toStringAsFixed(
                                                                        1),
                                                                style: TextStyle(
                                                                    color: CatchmongColors
                                                                        .gray_800,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Text(
                                                                "리뷰${partnerController.favoritePartners[index].reviews == null ? "0" : partnerController.favoritePartners[index].reviews!.isEmpty ? "0" : partnerController.favoritePartners[index].reviews!.length.toString()}",
                                                                style: TextStyle(
                                                                    color: CatchmongColors
                                                                        .gray_300,
                                                                    fontSize:
                                                                        12,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      SvgPicture.asset(
                                                          'assets/images/pin.svg'),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 12,
                                                ),
                                                SizedBox(
                                                  width: 150,
                                                  height: 30, // 필요한 높이로 설정
                                                  child: ListView.builder(
                                                    scrollDirection: Axis
                                                        .horizontal, // 가로 스크롤 설정
                                                    itemCount: partnerController
                                                                .favoritePartners[
                                                                    index]
                                                                .amenities ==
                                                            null
                                                        ? 0
                                                        : partnerController
                                                            .favoritePartners[
                                                                index]
                                                            .amenities!
                                                            .length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            int amenityIdx) {
                                                      if (partnerController
                                                          .favoritePartners[
                                                              index]
                                                          .amenities!
                                                          .isEmpty) {
                                                        return Container(); // 빈 리스트 처리
                                                      } else {
                                                        return Padding(
                                                          padding: const EdgeInsets
                                                              .only(
                                                              right:
                                                                  4.0), // 태그 간 간격 추가
                                                          child: TagChip(
                                                            label:
                                                                "# ${partnerController.favoritePartners[index].amenities![amenityIdx]}",
                                                          ),
                                                        );
                                                      }
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: 16,
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                              color: CatchmongColors.gray50,
                            )
                          ],
                        )
                      : partnerController.partners.isEmpty
                          ? Container(
                              height: 500,
                              child: Center(
                                child: Text("해당 파트너가 없습니다."),
                              ),
                            )
                          : Container(
                              height: 500,
                              child: ListView.builder(
                                  itemCount: partnerController.partners.length,
                                  itemBuilder: (context, index) {
                                    final partner =
                                        partnerController.partners[index];
                                    bool isScraped = loginController
                                            .user.value!.scrapPartners
                                            .firstWhereOrNull(
                                                (el) => el.id == partner.id) !=
                                        null;
                                    print(
                                        "${index}번째 파트너: ${partnerController.partners[index].id}");
                                    return ScrapPartnerCard(
                                      partner:
                                          partnerController.partners[index],
                                    );
                                  })))

                  // partnerController.partners.isEmpty
                ],
              ),
            ),
            Image.asset('assets/images/banner_payback.png')
          ],
        ),
      ),
    );
  }
}
