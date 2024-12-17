import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class MapChip extends StatelessWidget {
  final String title;
  final bool isActive;
  final double marginRight;
  final Widget leadingIcon;
  final bool useLeadingIcon;
  final double fontSize;
  final double verticalPadding;
  final void Function()? onTap;
  const MapChip({
    super.key,
    required this.title,
    required this.isActive,
    required this.marginRight,
    required this.leadingIcon,
    required this.useLeadingIcon,
    this.fontSize = 14,
    this.verticalPadding = 8,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: verticalPadding,
        ),
        margin: EdgeInsets.only(
          right: 8,
        ),
        decoration: BoxDecoration(
            color: isActive ? CatchmongColors.yellow_main : Colors.white,
            border: Border.all(
                color: isActive
                    ? CatchmongColors.yellow_main
                    : CatchmongColors.gray),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          children: [
            useLeadingIcon ? leadingIcon : Container(),
            useLeadingIcon
                ? SizedBox(
                    width: 4,
                  )
                : Container(),
            Text(
              title,
              style: TextStyle(
                color: isActive ? Colors.white : CatchmongColors.sub_gray,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
