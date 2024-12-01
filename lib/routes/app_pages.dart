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
import 'package:catchmong/modules/mypage/views/mypage_view.dart';
import 'package:catchmong/modules/mypage/views/profile_edit_view.dart';
import 'package:catchmong/modules/partner/bindings/partner-binding.dart';
import 'package:catchmong/modules/partner/views/partner-show-view.dart';
import 'package:catchmong/modules/search/bindings/search_binding.dart';
import 'package:catchmong/modules/search/views/search_view.dart';
import 'package:catchmong/modules/signup/bindings/signup_binding.dart';
import 'package:catchmong/modules/signup/views/certi_view.dart';
import 'package:catchmong/modules/signup/views/signup_view.dart';
import 'package:catchmong/widget/content/map_content.dart';
import 'package:catchmong/widget/content/partner_content.dart';
import 'package:catchmong/widget/content/qr_camera_content.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = '/location-setting';
  // static const INITIAL = '/main';

  static final routes = [
    GetPage(
      name: '/login',
      page: () => LoginView(),
    ),
    GetPage(
      name: '/loading',
      page: () => LoadingView(),
    ),
    GetPage(
      name: '/signup',
      page: () => SignupView(),
    ),
    GetPage(
      name: '/certi',
      page: () => CertiView(),
    ),
    GetPage(
      name: '/location',
      page: () => const LocationView(),
    ),
    GetPage(
      name: '/location-search',
      page: () => LocationSearchView(),
    ),
    GetPage(
      name: '/location-add',
      page: () => LocationAddView(),
    ),
    GetPage(
      name: '/location-setting',
      page: () => LocationSettingView(),
    ),
    GetPage(
      name: '/main',
      page: () => MainScreen(),
      children: [
        GetPage(
          name: '/home',
          page: () => MainView(),
        ),
        GetPage(
          name: '/search',
          page: () => PartnerContent(),
        ),
        GetPage(
          name: '/map',
          page: () => MapContent(),
        ),
        GetPage(
          name: '/qr',
          page: () => QrCameraContent(),
        ),
        GetPage(
          name: '/mypage',
          page: () => MyPageView(),
        ),
      ],
    ),
    GetPage(
      name: '/search',
      page: () => const SearchView(),
    ),
    GetPage(
      name: '/alarm',
      page: () => const AlarmView(),
    ),
    GetPage(
      name: '/alarm-setting',
      page: () => const AlarmSettingView(),
    ),
    GetPage(
      name: '/scrap',
      page: () => const ScrapView(),
    ),
    GetPage(
      name: '/my-write',
      page: () => const MyWriteView(),
    ),
    GetPage(
      name: '/my-purchase',
      page: () => const MyPurchaseView(),
    ),
    GetPage(
      name: '/my-setting',
      page: () => MypageSetting(),
    ),
    GetPage(
      name: '/profile-edit',
      page: () => const ProfileEditView(),
    ),
    GetPage(
      name: '/partner-show',
      page: () => const PartnerShowView(),
    ),
  ];
}
