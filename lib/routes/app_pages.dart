import 'package:catchmong/modules/loading/bindings/loading_binding.dart';
import 'package:catchmong/modules/loading/views/loading_view.dart';
import 'package:catchmong/modules/location/alarm/bindings/alarm_binding.dart';
import 'package:catchmong/modules/location/alarm/views/alarm_setting_view.dart';
import 'package:catchmong/modules/location/alarm/views/alarm_view.dart';
import 'package:catchmong/modules/location/bindings/location_binding.dart';
import 'package:catchmong/modules/location/scrap/bindings/scrap_binding.dart';
import 'package:catchmong/modules/location/scrap/views/scrap_view.dart';
import 'package:catchmong/modules/location/views/location_add_view.dart';
import 'package:catchmong/modules/location/views/location_search_view.dart';
import 'package:catchmong/modules/location/views/location_setting_view.dart';
import 'package:catchmong/modules/location/views/location_view.dart';
import 'package:catchmong/modules/login/bindings/login_binding.dart';
import 'package:catchmong/modules/login/views/login_view.dart';
import 'package:catchmong/modules/main/bindings/main_bindings.dart';
import 'package:catchmong/modules/main/views/main_view.dart';
import 'package:catchmong/modules/mypage/bindings/mypage_binding.dart';
import 'package:catchmong/modules/mypage/views/my_purchase_view.dart';
import 'package:catchmong/modules/mypage/views/my_write_view.dart';
import 'package:catchmong/modules/mypage/views/mypage_setting.dart';
import 'package:catchmong/modules/mypage/views/profile_edit_view.dart';
import 'package:catchmong/modules/partner/bindings/partner-binding.dart';
import 'package:catchmong/modules/partner/views/partner-show-view.dart';
import 'package:catchmong/modules/search/bindings/search_binding.dart';
import 'package:catchmong/modules/search/views/search_view.dart';
import 'package:catchmong/modules/signup/bindings/signup_binding.dart';
import 'package:catchmong/modules/signup/views/certi_view.dart';
import 'package:catchmong/modules/signup/views/signup_view.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = '/login';
  // static const INITIAL = '/main';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: '/loading',
      page: () => LoadingView(),
      binding: LoadingBinding(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: '/certi',
      page: () => CertiView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: '/location',
      page: () => const LocationView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: '/location-search',
      page: () => LocationSearchView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: '/location-add',
      page: () => LocationAddView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: '/location-setting',
      page: () => LocationSettingView(),
      binding: LocationBinding(),
    ),
    GetPage(
      name: '/main',
      page: () => MainScreen(),
      binding: MainBinding(),
    ),
    GetPage(
      name: '/search',
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: '/alarm',
      page: () => const AlarmView(),
      binding: AlarmBinding(),
    ),
    GetPage(
      name: '/alarm-setting',
      page: () => const AlarmSettingView(),
      binding: AlarmBinding(),
    ),
    GetPage(
      name: '/scrap',
      page: () => const ScrapView(),
      binding: ScrapBinding(),
    ),
    GetPage(
      name: '/my-write',
      page: () => const MyWriteView(),
      binding: MypageBinding(),
    ),
    GetPage(
      name: '/my-purchase',
      page: () => const MyPurchaseView(),
      binding: MypageBinding(),
    ),
    GetPage(
      name: '/my-setting',
      page: () => MypageSetting(),
      binding: MypageBinding(),
    ),
    GetPage(
      name: '/profile-edit',
      page: () => const ProfileEditView(),
      binding: MypageBinding(),
    ),
    GetPage(
        name: '/partner-show',
        page: () => const PartnerShowView(),
        binding: PartnerBinding()),
  ];
}
