import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class LoginController extends GetxController {
  // 이미지 표시 여부를 관리하는 반응형 변수
  final UserService userService = UserService();
  var showLatestLoginImage = true.obs;
  var users = <dynamic>[].obs;
  var isLoading = false.obs;
  final String baseUrl = 'http://192.168.200.102:3000';
  var user = Rxn<User>();
  Rx<File?> selectedImage = Rx<File?>(null);
  RxString nickname = RxString("");
  RxString phone = RxString("");
  RxString gender = RxString("남성");
  RxString paybackMethod = RxString("바로바로 받기");
  RxString referrerNickname = RxString("");
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController paybackMethodController = TextEditingController();
  final TextEditingController referrerNicknameController =
      TextEditingController();
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    try {
      // 갤러리에서 이미지 선택
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        selectedImage.value = File(image.path); // 선택한 이미지 업데이트
        print("선택한 이미지 경로: ${image.path}");
      }
    } catch (e) {
      print("이미지 선택 오류: $e");
    }
  }

  void setUser(User userData) {
    print("user value 00>>>${userData}");
    user.value = userData;
    print("user value>>>${user.value}");
  }

  // 로그아웃 시 사용자 정보 초기화
  void clearUser() {
    user.value = null;
  }

  Future<String?> handleGoogleSignIn() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: ['email', 'profile']);
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication auth = await account!.authentication;
      print('구글로그인 토큰: ${auth.idToken}');
      return auth.idToken; // ID 토큰 반환
    } catch (e) {
      print('구글로그인 에러/임시 토큰 넘겨주기: $e');
      // return null;
      return "temp";
    }
  }

  Future<void> postAdditionalInfo() async {
    var url = '$baseUrl/api/user/additional-info';
    final Map<String, dynamic> body = {
      'name': user.value?.name,
      'email': user.value?.email,
      'sub': user.value?.sub,
      'nickname': nicknameController.text,
      'phone': phoneController.text,
      'gender': gender.value,
      'paybackMethod': paybackMethod.value,
      'referrerNickname': referrerNicknameController.text,
    };
    print('닉네임: ${nicknameController.text}');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('서버 응답: ${responseData['message']}');
        print('저장된 데이터: ${responseData['data']}');
        Get.toNamed('/certi');
      } else if (response.statusCode == 400) {
        final errorData = jsonDecode(response.body);
        print('오류: ${errorData['error']} // ${errorData['message']}');
      } else {
        final errorData = jsonDecode(response.body);
        print(
            '예상치 못한 오류 발생: ${response.statusCode} // ${errorData['message']}');
      }
    } catch (error) {
      print('서버 요청 중 오류 발생: $error');
    }
  }

  Future<void> loginWithGoogle(String? idToken) async {
    if (idToken == null) {
      print("ID 토큰이 없습니다.");
      return;
    }

    try {
      var url = '$baseUrl/auth/google';
      final response = await http.post(
        Uri.parse(url), // 서버 URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'idToken': idToken,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("구글 로그인 성공: ${responseData['user']}");
        User user = User.fromJson(responseData['user']);
        // selectedImage.value = File(user.picture );

        setUser(user);
        Get.toNamed("/signup");
      } else {
        print("구글 로그인 실패: ${response.body}");
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
    }
  }

  // 사용자 목록 가져오기
  Future<void> loadUsers() async {
    try {
      print("load user");
      isLoading.value = true;
      var aaa = await userService.fetchUsers();
      print("[GET] backend test success>>> ${aaa}");
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    loadUsers();
    // 5초 후에 이미지 표시를 중단합니다.
    Timer(Duration(seconds: 5), () {
      showLatestLoginImage.value = false;
    });
  }
}
