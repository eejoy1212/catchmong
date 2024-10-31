import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class MoreBtn extends StatelessWidget {
  const MoreBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        "더보기",
        style: TextStyle(
          color: CatchmongColors.gray400,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
