import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
