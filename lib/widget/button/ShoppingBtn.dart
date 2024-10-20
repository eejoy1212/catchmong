import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ShoppingBtn extends StatelessWidget {
  const ShoppingBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed('/search');
        },
        child: Image.asset('assets/images/shopping-icon.png'));
  }
}
