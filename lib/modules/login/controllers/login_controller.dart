import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
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
  RxString ageGroup = RxString("10대");
  RxString nicknameErrTxt = RxString("");
  RxString phoneErrTxt = RxString("");
  RxString referrerNicknameErrTxt = RxString("");
  RxString generalErrTxt = RxString("");
  final TextEditingController vertiCodeController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController paybackMethodController = TextEditingController();
  final TextEditingController referrerNicknameController =
      TextEditingController();
  // 타이머 관련 변수
  RxInt remainingSeconds = 600.obs; // 10분 (600초)
  Timer? countdownTimer;
  RxBool isVerified = false.obs; // 인증 성공 여부
  RxInt generatedCode = RxInt(0); // 서버에서 생성된 인증번호 저장
  @override
  void onInit() {
    super.onInit();
    loadUsers();
    print("now user>>> ${user.value?.email}");

    // 5초 후에 이미지 표시를 중단합니다.
    Timer(Duration(seconds: 5), () {
      showLatestLoginImage.value = false;
    });
  }

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

  // void setUser(User userData) {
  //   print("user value 00>>>${userData}");
  //   user.value = userData;
  //   print("user value>>>${user.value}");
  // }

  // 로그아웃 시 사용자 정보 초기화
  // void clearUser() {
  //   user.value = null;
  // }

  String generateRandomEmail() {
    // 랜덤 ID 생성
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    final String randomId =
        List.generate(10, (index) => chars[random.nextInt(chars.length)])
            .join();

    // 이메일 주소 생성
    return '$randomId@gmail.com';
  }

  String generateRandomSub() {
    // 랜덤 ID 생성
    const String chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final Random random = Random();
    final String randomId =
        List.generate(10, (index) => chars[random.nextInt(chars.length)])
            .join();

    // 이메일 주소 생성
    return randomId;
  }

  Future<List?> handleGoogleSignIn() async {
    final GoogleSignIn googleSignIn =
        GoogleSignIn(scopes: ['email', 'profile']);
    String randomEmail = generateRandomEmail();
    String randomSub = generateRandomSub();
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication auth = await account!.authentication;
      print('구글로그인 토큰: ${auth.idToken} // ${account.email}');

      return [
        auth.idToken,
        randomEmail,
        randomSub,
        selectedImage.value?.path,
        randomSub,
      ]; // ID 토큰 반환
    } catch (e) {
      print('구글로그인 에러/임시 토큰 넘겨주기: $e');
      return [
        "temp",
        randomEmail,
        randomSub,
        selectedImage.value?.path,
        randomSub,
      ];
      return null;
    }
  }

  Future<void> postAdditionalInfo() async {
    if (!isVerified.value) {
      print("회원가입 실패: 인증이 완료되지 않았습니다.");
      return;
    }

    var url = '$baseUrl/api/user/additional-info';
    final Map<String, dynamic> body = {
      'name': generateRandomSub(),
      'email': generateRandomEmail(),
      'sub': generateRandomSub(),
      'nickname': nicknameController.text,
      'phone': phoneController.text,
      'gender': gender.value,
      'paybackMethod': paybackMethod.value,
      'referrerNickname': referrerNicknameController.text,
      'ageGroup': ageGroup.value,
      'picture': "",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] == null) {
          print("서버에서 'data' 필드가 비어 있습니다.");
          return;
        }

        // user.value 업데이트
        try {
          final storage = GetStorage();

// 데이터 저장
          storage.write('user', responseData['data']);

          user.value = User.fromJson(responseData['data']);
          if (user.value != null) {
            nicknameController.text = user.value!.nickname;
            phoneController.text = user.value!.phone;
            gender.value = user.value!.gender;
            ageGroup.value = user.value!.ageGroup;
            paybackMethod.value = user.value!.paybackMethod;
            referrerNicknameController.text = user.value!.referrerId.toString();
          }
          print("user.value 업데이트 완료: ${user.value?.toJson()}");
        } catch (e) {
          print("User.fromJson에서 오류 발생: $e");
        }
      } else {
        print("회원가입 실패: ${response.body}");
      }
    } catch (error) {
      print("서버 요청 중 오류 발생: $error");
    }
  }

  Future<void> postSendVerti() async {
    var url = '$baseUrl/api/user/send-verification';
    final phone = phoneController.text;
    print("phone send code>>> $phone");
    if (phone.isEmpty) {
      print('전화번호가 입력되지 않았습니다.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'phone': phone,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final code = responseData["data"];
        print("인증번호 전송 성공: ${responseData['message']}");
        vertiCodeController.text =
            code.toString(); //문자로 전송된 인증번호 자동으로 입력되게 하는걸로 수정하자 twillio 달고
        generatedCode.value = code; // 서버에서 받은 인증번호 저장
        startTimer(); // 타이머 시작
      } else {
        final errorData = jsonDecode(response.body);
        print("인증번호 전송 실패: ${errorData['error'] ?? response.body}");
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
    }
  }

  Future<void> verifyCode() async {
    final url = '$baseUrl/api/user/verify-code';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
          {'phone': phoneController.text, 'code': vertiCodeController.text}),
    );

    if (response.statusCode == 200) {
      isVerified.value = true;
      print('인증 성공');
    } else {
      isVerified.value = false;
      print('인증 실패');
    }
  }

  Future<void> loginWithGoogle(List? auth) async {
    print("auth $auth");
    if (auth == null || auth.length < 5) {
      print("Google 인증 데이터가 올바르지 않습니다.");
      return;
    }

    try {
      var url = '$baseUrl/auth/google'; // 서버의 구글 로그인 엔드포인트
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'idToken': auth[0], // Google ID Token
          'email': auth[1], // Google Email
          'sub': '2jxgq02ry2', //auth[2], // Google User ID (sub)
          'picture': auth[3] ?? "", // Profile Picture
          'name': auth[4], // Name
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['requiresAdditionalInfo'] == true) {
          // 신규 회원: 추가 정보 입력 페이지로 이동
          final googleUser = responseData['googleUser'];
          print("추가 정보 필요: $googleUser");
          Get.toNamed("/signup", arguments: googleUser); // 추가 정보 페이지로 이동
        } else {
          // 기존 회원: 로그인 성공 처리
          final originUser = responseData['user'];

          user.value = User.fromJson(originUser);
          print("구글 로그인 성공: ${user.value}");
          Get.toNamed("/main"); // 메인 페이지로 이동
        }
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

  // 타이머 시작
  void startTimer() {
    stopTimer(); // 기존 타이머 중단
    remainingSeconds.value = 600; // 10분 초기화
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        timer.cancel(); // 타이머 종료
      }
    });
  }

  // 타이머 중단
  void stopTimer() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
  }

  @override
  void onClose() {
    super.onClose();
    stopTimer(); // 컨트롤러 종료 시 타이머 중단
  }
}
