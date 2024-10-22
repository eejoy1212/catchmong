import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class AcitivityContent extends StatelessWidget {
  const AcitivityContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true, // 부모 위젯에 맞춰 사이즈 조정
        physics:
            const NeverScrollableScrollPhysics(), // SingleChildScrollView로 스크롤 처리
        itemCount: 20, // 열 개의 아이템 생성
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // 클릭 시 동작 추가
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(
                    width: 1,
                    color: CatchmongColors.gray50,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // ActivityReviewChip(),
                      Image.asset('assets/images/activity-review-chip.png'),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "1일 전",
                        style: TextStyle(
                          color: CatchmongColors.gray400,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Spacer(),
                      Stack(children: [
                        Container(
                          margin: EdgeInsets.only(
                            left: 8,
                            top: 2,
                            bottom: 2,
                          ),
                          child: Text(
                            "New",
                            style: TextStyle(
                              color: CatchmongColors.gray_800,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 5,
                            height: 5,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color: CatchmongColors.yellow,
                            ),
                          ),
                        )
                      ])
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("원희 사장님이 내 리뷰에 리뷰&평점을 보냈어요.")
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
