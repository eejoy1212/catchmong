import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class OutlinedBtn extends StatelessWidget {
  final double? width;
  final double height;
  final String title;
  const OutlinedBtn({
    super.key,
    this.width = 220,
    this.height = 52,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8))),
      child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // radius를 8로 설정
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                  color: CatchmongColors.gray100, width: 1), // 보더 컬러를 노란색으로 설정
            ),
          ),
          onPressed: () {},
          child: Text(
            title,
            style: TextStyle(
                color: CatchmongColors.black,
                fontSize: 16,
                fontWeight: FontWeight.w700),
          )),
    );
  }
}
