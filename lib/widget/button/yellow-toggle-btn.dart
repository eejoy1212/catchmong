import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class YellowToggleBtn extends StatelessWidget {
  final double? width;
  final double height;
  final String title;
  final bool isSelected;
  final void Function()? onTap;
  final EdgeInsetsGeometry? margin;
  final bool isDisabled;
  const YellowToggleBtn({
    super.key,
    this.width = 220,
    this.height = 48,
    required this.title,
    required this.isSelected,
    this.onTap,
    this.margin,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
          color: isDisabled
              ? CatchmongColors.gray50
              : isSelected
                  ? CatchmongColors.yellow_main
                  : Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: OutlinedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8), // radius를 8로 설정
              ),
            ),
            side: MaterialStateProperty.all(
              BorderSide(
                  color: isDisabled
                      ? CatchmongColors.gray100
                      : isSelected
                          ? CatchmongColors.yellow_line
                          : CatchmongColors.gray100,
                  width: 1), // 보더 컬러를 노란색으로 설정
            ),
          ),
          onPressed: isDisabled ? null : onTap,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  color: isDisabled
                      ? CatchmongColors.gray400
                      : isSelected
                          ? Colors.white
                          : CatchmongColors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          )),
    );
  }
}
