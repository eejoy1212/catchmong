import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBtn extends StatelessWidget {
  SearchBtn({super.key});
  final BottomNavController _controller = Get.put(BottomNavController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Get.toNamed('/search');
          _controller.onItemTapped(1);
        },
        child: Image.asset('assets/images/search-icon.png'));
  }
}
