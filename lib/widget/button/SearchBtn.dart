import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchBtn extends StatelessWidget {
  const SearchBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed('/search');
        },
        child: Image.asset('assets/images/search-icon.png'));
  }
}
