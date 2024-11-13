import 'dart:io';

import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Android WebView 초기화 (최신 코드)
  // if (Platform.isAndroid) {
  //   WebView.platform = AndroidWebView();
  // }
  await NaverMapSdk.instance.initialize(clientId: "9ue8t44jzd");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          useMaterial3: false,
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
