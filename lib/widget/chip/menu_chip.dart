import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class MenuChip extends StatelessWidget {
  final String title;
  final Color bgColor;
  const MenuChip({
    super.key,
    required this.title,
    this.bgColor = CatchmongColors.gray50,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        // width: 100,
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: bgColor,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              color: CatchmongColors.sub_gray,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
