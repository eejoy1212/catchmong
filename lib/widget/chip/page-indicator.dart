import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final bool isCurrent;
  const PageIndicator({super.key, required this.isCurrent});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8, // 동그라미의 너비
      height: 8, // 동그라미의 높이
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        color:
            isCurrent ? CatchmongColors.yellow_line : Colors.white, // 동그라미 색상
        shape: BoxShape.circle, // 동그라미 모양
      ),
    );
  }
}
