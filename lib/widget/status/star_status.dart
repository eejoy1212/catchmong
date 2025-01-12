import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StarStatus extends StatelessWidget {
  final double rating;
  const StarStatus({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/images/review-star.svg'),
        SizedBox(
          width: 4,
        ),
        Container(
          margin: EdgeInsets.only(top: 4),
          child: Text(
            rating.toStringAsFixed(1),
            style: TextStyle(
                color: CatchmongColors.gray_800,
                fontSize: 12,
                fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
