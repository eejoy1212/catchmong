import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Center(
        child: Text(
          '메인 페이지',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
