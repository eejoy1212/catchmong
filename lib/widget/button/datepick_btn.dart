import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/widget/button/outline_btn_with_icon.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickBtn extends StatelessWidget {
  final DateTime startDate;
  final DateTime endDate;
  final void Function() onPress;
  const DatePickBtn(
      {super.key,
      required this.startDate,
      required this.endDate,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    return OutlinedBtnWithIcon(
      height: 48,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            DateFormat('yy.MM.dd').format(startDate) +
                "~" +
                DateFormat('yy.MM.dd').format(endDate),
            style: TextStyle(
              color: CatchmongColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          Icon(
            Icons.calendar_today_rounded,
            size: 16,
            color: CatchmongColors.black,
          ),
        ],
      ),
      onPress: onPress,
    );
  }
}
