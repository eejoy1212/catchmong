import 'package:flutter/material.dart';

class InfoBtn extends StatelessWidget {
  const InfoBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        'assets/images/info-icon.png',
        width: 24, // 적절한 크기로 설정
        height: 24, // 적절한 크기로 설정
      ),
    );
  }
}
