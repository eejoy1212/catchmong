import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 16, bottom: 16),
          child: Row(
            children: [
              Text(
                '모든지역',
                style: TextStyle(
                    color: CatchmongColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              Image.asset('assets/images/right-arrow.png')
            ],
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 260,
              color: CatchmongColors.gray,
            ),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Image.asset('assets/images/partner.png')),
                        Expanded(child: Image.asset('assets/images/store.png')),
                        Expanded(
                            child: Image.asset('assets/images/payback.png')),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
