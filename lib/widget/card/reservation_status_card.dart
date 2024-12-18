import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:flutter/material.dart';

enum ReservationStatus {
  waiting,
  confirmed,
}

class ReservationStatusCard extends StatelessWidget {
  final double width;
  final ReservationStatus status;

  const ReservationStatusCard({
    super.key,
    required this.width,
    required this.status,
  });

  String getStatusText() {
    switch (status) {
      case ReservationStatus.waiting:
        return "예약대기";
      case ReservationStatus.confirmed:
        return "예약확정";
    }
  }

  Color getStatusColor() {
    switch (status) {
      case ReservationStatus.waiting:
        return CatchmongColors.red;
      case ReservationStatus.confirmed:
        return CatchmongColors.blue2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        top: 16,
        right: 20,
        bottom: 32,
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: CatchmongColors.gray50,
      ))),
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            getStatusText(),
            style: TextStyle(
              color: getStatusColor(),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //이미지
              Expanded(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      color: CatchmongColors.gray,
                      width: 1,
                    ), // 외부 테두리
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), // 이미지를 둥글게 자르기
                    child: Image.asset(
                      'assets/images/review2.jpg', // 이미지 경로
                      fit: BoxFit.cover, // 이미지가 Container 크기에 맞게 자르기
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "2024.11.25 | 오후 5:30",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: CatchmongColors.gray_800,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "평일 예약(11시30분~20:00분)",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: CatchmongColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "예약자 : 캐치몽닉네임",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CatchmongColors.black,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    "연락처 : 010-0000-0000",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: CatchmongColors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 12,
              ),
              const Text(
                "4명",
                style: TextStyle(
                  color: CatchmongColors.gray_800,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          status == ReservationStatus.confirmed
              ? Container()
              : Row(
                  children: [
                    Expanded(
                      child: OutlinedBtn(title: "예약 취소", onPress: () {}),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: OutlinedBtn(
                        title: "예약 확정",
                        fontColor: CatchmongColors.blue2,
                        onPress: () {},
                      ),
                    )
                  ],
                )
        ],
      ),
    );
  }
}
