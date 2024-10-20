import 'package:catchmong/modules/location/bindings/location_binding.dart';
import 'package:catchmong/modules/location/views/location_setting_view.dart';
import 'package:catchmong/modules/location/views/location_view.dart';
import 'package:catchmong/modules/login/bindings/login_binding.dart';
import 'package:catchmong/modules/login/views/login_view.dart';
import 'package:catchmong/modules/main/bindings/main_bindings.dart';
import 'package:catchmong/modules/main/views/main_view.dart';
import 'package:catchmong/modules/search/bindings/search_binding.dart';
import 'package:catchmong/modules/search/views/search_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = '/login';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/location',
      page: () => LocationView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: '/location-setting',
      page: () => LocationSettingView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: '/main',
      page: () => MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/search',
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
  ];
}
