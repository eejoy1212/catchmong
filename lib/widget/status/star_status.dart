import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class StarStatus extends StatelessWidget {
  const StarStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset('assets/images/review-star.png'),
        SizedBox(
          width: 4,
        ),
        Text(
          '5.0',
          style: TextStyle(
              color: CatchmongColors.gray_800,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}
