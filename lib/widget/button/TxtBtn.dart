import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class TxtBtn extends StatelessWidget {
  const TxtBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 52,
      child: TextButton(
        onPressed: () {},
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // 보더 반경 설정
          ),
        ),
        child: Text(
          "구경 먼저 할게요",
          style: TextStyle(
              color: CatchmongColors.sub_gray,
              fontWeight: FontWeight.w700,
              fontSize: 16), // 텍스트 색상 설정
        ),
      ),
    );
  }
}
