import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class ReservationCard extends StatelessWidget {
  final String imageSrc;
  const ReservationCard({super.key, required this.imageSrc});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      width: width, // 컨테이너 너비
      // height: 200, // 컨테이너 높이
      decoration: BoxDecoration(
        border: Border.all(color: CatchmongColors.gray50),
        color: Colors.white, // 컨테이너 배경색
        boxShadow: [
          BoxShadow(
            color: Color(0x40000000), // #00000040 (불투명도 25%)
            offset: Offset(0, 4), // 그림자의 X, Y 방향 위치
            blurRadius: 4, // 흐림 정도
            spreadRadius: 0, // 그림자 확산 정도
          ),
        ],
        borderRadius: BorderRadius.circular(12), // 컨테이너의 모서리 둥글기
      ),
      child: Center(
        child: Column(
          children: [
            Container(
                height: 200,
                child: Center(
                    child: Text(
                  "첨부한 \n가게사진",
                  textAlign: TextAlign.center,
                ))),
            Divider(
              color: CatchmongColors.gray100,
            ),
            Container(
              width: width,
              height: 128,
              margin: EdgeInsets.only(
                left: 20,
                top: 10,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "평일 예약(11시30분~20시00분)",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "*예약은 최소 1시간전 시간부터 가능합니다.\n예약 시간맞춰서 방문 부탁드립니다.\n*예약시 이탈리아 최고급 탄산수(1병)를 서비스로 드리고 있습니다!\n노쇼 혹은 당일취소는 저희들뿐 아니라 다른 고객분들께 피해가 됩니다.\n신중하게 예약하시길 부탁드립니다!",
                    style: TextStyle(
                      color: CatchmongColors.gray_800,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 5, // 최대 줄 수
                    overflow: TextOverflow.ellipsis, // 초과된 텍스트를 ...로 표시
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
