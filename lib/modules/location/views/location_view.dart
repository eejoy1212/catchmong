import 'package:catchmong/widget/button/TxtBtn.dart';
import 'package:catchmong/widget/button/YellowElevationBtn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(
                'assets/images/location-txt.png',
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Image.asset(
                'assets/images/map.png',
              ),
            ),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: YellowElevationBtn(
                    title: Text(
                      "지도에서 설정하기",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ), // 텍스트 색상 설정
                    ),
                    onPressed: () async {
                      // 라우팅 수행
                      await Get.toNamed('/location-setting');
                    },
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TxtBtn())
              ],
            )
          ],
        ),
      ),
    );
  }
}
