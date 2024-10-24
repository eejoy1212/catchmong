import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/outlined_btn.dart';
import 'package:flutter/material.dart';

class ScrapPartnerContent extends StatelessWidget {
  const ScrapPartnerContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 192,
          color: Colors.white,
          padding: EdgeInsets.only(
            top: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "스크랩이 비어있어요.\n관심있는 매장을 저장해보세요.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: CatchmongColors.gray400,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 16,
              ),
              OutlinedBtn(
                title: "매장 보러가기",
              )
            ],
          ),
        ),
      ],
    );
  }
}
