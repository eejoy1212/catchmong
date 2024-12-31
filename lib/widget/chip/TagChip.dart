import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class TagChip extends StatelessWidget {
  final String label;

  TagChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8), // 오른쪽 마진 8px
      padding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 3), // 좌우 패딩 12px
      decoration: BoxDecoration(
        border: Border.all(
          color: CatchmongColors.yellow_main, // --yellow (#F5C626) 색상
          width: 1, // 테두리 두께 1px
        ),
        borderRadius: BorderRadius.circular(20), // 둥근 모서리 반지름 20px
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 14, // 텍스트 크기
          fontWeight: FontWeight.w500, // 텍스트 굵기
          color: Colors.black, // 텍스트 색상
        ),
      ),
    );
  }
}
