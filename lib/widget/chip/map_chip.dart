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
  final Color? activeColor;
  final Color? activeTxtColor;
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
    this.activeColor = CatchmongColors.yellow_main,
    this.activeTxtColor = Colors.white,
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
            color: isActive ? activeColor : Colors.white,
            border: Border.all(
                color: isActive
                    ? CatchmongColors.yellow_main
                    : CatchmongColors.gray),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
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
                color: isActive ? activeTxtColor : CatchmongColors.sub_gray,
                fontSize: fontSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
