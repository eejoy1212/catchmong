import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/AppbarBackBtn.dart';
import 'package:catchmong/widget/card/my_write_card.dart';
import 'package:catchmong/widget/card/partner-review-card.dart';
import 'package:catchmong/widget/chip/map_chip.dart';
import 'package:flutter/material.dart';

class MyWriteView extends StatelessWidget {
  const MyWriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const AppbarBackBtn(),
        centerTitle: true,
        title: const Text(
          "내가 쓴 글",
          style: TextStyle(
              color: CatchmongColors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 8,
                  bottom: 16,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: CatchmongColors.gray50,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "내가 쓴 리뷰 27개",
                      style: TextStyle(
                        color: CatchmongColors.gray_800,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "리뷰 수정 안내",
                      style: TextStyle(
                        color: CatchmongColors.gray400,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              // 글 리스트
              ListView.builder(
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MyWriteCard();
                },
              ),
            ],
          ),
          // 최상단에 위치하도록 Positioned로 MapChip 추가
          //지우지 마시오
          // Positioned(
          //   right: 0,
          //   top: 30, // 필요한 위치로 조정
          //   child: MapChip(
          //     title: "주문 후 3일이 지났거나, 차단된 리뷰는 수정할 수 없습니다.",
          //     isActive: false,
          //     marginRight: 0,
          //     leadingIcon: Container(),
          //     useLeadingIcon: false,
          //   ),
          // ),
        ],
      ),
    );
  }
}
