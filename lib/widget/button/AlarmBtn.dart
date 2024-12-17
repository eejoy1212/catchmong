import 'package:catchmong/modules/location/alarm/views/alarm_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AlarmBtn extends StatelessWidget {
  const AlarmBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          showAlarm(context);
        },
        child: SvgPicture.asset('assets/images/alarm-icon.svg'));
  }
}

void showAlarm(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  showGeneralDialog(
    context: context,
    barrierDismissible: true, // true로 설정했으므로 barrierLabel 필요
    barrierLabel: "닫기", // 접근성 레이블 설정
    barrierColor: Colors.black54, // 배경 색상
    pageBuilder: (context, animation, secondaryAnimation) {
      return AlarmView();
    },
  );
}
