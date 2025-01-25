import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class OutlinedBtnWithIcon extends StatelessWidget {
  final double? width;
  final double height;
  final Widget title;
  final double fontSize;
  final void Function() onPress;
  final bool? isDisabled;
  const OutlinedBtnWithIcon({
    super.key,
    this.width = 220,
    this.height = 52,
    required this.title,
    this.fontSize = 16,
    required this.onPress,
    this.isDisabled = false,
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
          onPressed: (isDisabled ?? false) ? null : onPress,
          child: title),
    );
  }
}
