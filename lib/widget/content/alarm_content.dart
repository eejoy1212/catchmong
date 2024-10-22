import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class AlarmContent extends StatelessWidget {
  const AlarmContent({super.key});

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "[공지] 타이틀을 작성해주세요. ${index + 1}", // 인덱스를 통해 타이틀 변경 가능
                        style: TextStyle(
                          color: CatchmongColors.gray_800,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "2024년 10월 13일",
                        style: TextStyle(
                          color: CatchmongColors.gray400,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  InkWell(
                    child: Image.asset('assets/images/right-arrow.png'),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
