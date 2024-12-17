import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LocationAddView extends StatelessWidget {
  const LocationAddView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: AppbarBackBtn(),
        title: Text(
          "내 지역 설정",
          style: TextStyle(
              color: CatchmongColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // 지역 추가하기 버튼
          InkWell(
            onTap: () {
              Get.toNamed('/location-setting');
            },
            child: Container(
              margin: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 20,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 12,
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: CatchmongColors.gray,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/location-add-icon.png'),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "지역 추가하기",
                    style: TextStyle(
                      color: CatchmongColors.sub_gray,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 나머지 리스트 영역
          Expanded(
            child: ListView(
              children: [
                // 가로선
                Container(
                  height: 1,
                  color: CatchmongColors.gray50,
                ),
                Image.asset(
                  "assets/images/location-add-banner.png",
                  width: MediaQuery.of(context).size.width,
                ),
                // 세로 스크롤 리스트
                ListView.builder(
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // 부모 ListView와 충돌하지 않도록 스크롤 비활성화
                  itemCount: 20, // 리스트 아이템 개수 설정
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 32,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: CatchmongColors.gray50,
                      )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Opacity(
                              opacity: index == 0 ? 1 : 0,
                              child: SvgPicture.asset(
                                  'assets/images/location-arrow.svg')),
                          SizedBox(
                            width: 20,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    index == 0 ? "모든 지역" : "친구 집 $index",
                                    style: TextStyle(
                                      color: CatchmongColors.gray_800,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  MapChip(
                                    title: "현재 설정된 주소",
                                    isActive: true,
                                    marginRight: 0,
                                    leadingIcon: Container(),
                                    useLeadingIcon: false,
                                    fontSize: 12,
                                    verticalPadding: 4,
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "서울특별시 서초구 강남대로 405-2",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: CatchmongColors.gray_300,
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              index == 0
                                  ? Container()
                                  : Row(
                                      children: [
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                                color: CatchmongColors.gray50,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Text(
                                              "수정",
                                              style: TextStyle(
                                                color: CatchmongColors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 4,
                                            ),
                                            decoration: BoxDecoration(
                                                color: CatchmongColors.gray50,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(20))),
                                            child: Text(
                                              "삭제",
                                              style: TextStyle(
                                                color: CatchmongColors.black,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
