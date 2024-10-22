import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class ActivityReviewChip extends StatelessWidget {
  const ActivityReviewChip({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8),
      decoration:
          BoxDecoration(border: Border.all(color: CatchmongColors.gray)),
      child: Text(
        "리뷰",
        style: TextStyle(
            color: CatchmongColors.black,
            fontSize: 10,
            fontWeight: FontWeight.w400),
      ),
    );
  }
}
