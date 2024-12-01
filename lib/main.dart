import 'dart:io';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/modules/bottom_nav/bottom_nav_controller.dart';
import 'package:catchmong/modules/loading/controllers/loading_controller.dart';
import 'package:catchmong/modules/location/alarm/controllers/alarm_controller.dart';
import 'package:catchmong/modules/location/controllers/location_controller.dart';
import 'package:catchmong/modules/login/controllers/login_controller.dart';
import 'package:catchmong/routes/app_pages.dart';
import 'package:catchmong/widget/content/payback_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Android WebView 초기화 (최신 코드)
  // if (Platform.isAndroid) {
  //   WebView.platform = AndroidWebView();
  // }
  await NaverMapSdk.instance.initialize(clientId: "9ue8t44jzd");
  Get.put(LoginController());
  Get.put(LoadingController());
  Get.put(LocationController());
  Get.put(BottomNavController());
  Get.put(AlarmController());
  Get.put(PaybackController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: false,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(color: Colors.white, elevation: 0),
          dialogTheme: DialogTheme(
            shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(24), // 전역적으로 다이얼로그에 radius 24 적용
            ),
          ),
          colorScheme: ColorScheme.fromSeed(
            seedColor: CatchmongColors.yellow_main,
            primary: CatchmongColors.yellow_main,
          )),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'GetX App',
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
