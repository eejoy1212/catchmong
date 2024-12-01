import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBtn extends StatelessWidget {
  SearchBtn({super.key});
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Get.toNamed('/search');
        },
        child: Image.asset('assets/images/search-icon.png'));
  }
}
