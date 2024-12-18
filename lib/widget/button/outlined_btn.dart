import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class OutlinedBtn extends StatelessWidget {
  final double? width;
  final double height;
  final String title;
  final double fontSize;
  final Color? fontColor;
  final void Function() onPress;
  const OutlinedBtn({
    super.key,
    this.width = 220,
    this.height = 52,
    required this.title,
    this.fontSize = 16,
    required this.onPress,
    this.fontColor = CatchmongColors.black,
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
          onPressed: onPress,
          child: Text(
            title,
            style: TextStyle(
                color: fontColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w700),
          )),
    );
  }
}
