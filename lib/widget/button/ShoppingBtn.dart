import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShoppingBtn extends StatelessWidget {
  const ShoppingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Get.toNamed('/scrap');
        },
        child: SvgPicture.asset('assets/images/shopping-icon.svg'));
  }
}
