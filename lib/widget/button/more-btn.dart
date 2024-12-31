import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class MoreBtn extends StatelessWidget {
  final bool isExpanded;
  final void Function() onTap;
  const MoreBtn({super.key, required this.onTap, required this.isExpanded});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Text(
        isExpanded ? "숨기기" : "더보기",
        style: TextStyle(
          color: CatchmongColors.gray400,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
