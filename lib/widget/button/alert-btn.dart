import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class AlertBtn extends StatelessWidget {
  const AlertBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/images/alert-icon.png'),
            SizedBox(
              width: 4,
            ),
            Text(
              "알림받기",
              style: TextStyle(color: CatchmongColors.sub_gray, fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
