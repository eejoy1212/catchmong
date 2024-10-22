import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AlarmBtn extends StatelessWidget {
  const AlarmBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed('/alarm');
        },
        child: Image.asset('assets/images/alarm-icon.png'));
  }
}
