import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/model/referrer.dart';
import 'package:catchmong/services/user_service.dart';
import 'package:flutter/material.dart';
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
  var referrer = Rxn<Referrer>();
  var referreds = <Referrer>[].obs;
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

  Future<bool> postAdditionalInfo() async {
    if (!isVerified.value) {
      print("회원가입 실패: 인증이 완료되지 않았습니다.");
      return false;
    }

    var url = '$baseUrl/api/user/additional-info';

    try {
      // MultipartRequest 생성
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // JSON 데이터 추가
      request.fields['name'] = generateRandomSub();
      request.fields['email'] = generateRandomEmail();
      request.fields['sub'] = generateRandomSub();
      request.fields['nickname'] = nicknameController.text;
      request.fields['phone'] = phoneController.text;
      request.fields['gender'] = gender.value;
      request.fields['paybackMethod'] = paybackMethod.value;
      request.fields['referrerNickname'] = referrerNicknameController.text;
      request.fields['ageGroup'] = ageGroup.value;

      // 이미지 파일 추가 (선택적)
      if (selectedImage.value != null) {
        try {
          var stream = http.ByteStream(selectedImage.value!.openRead());
          var length = await selectedImage.value!.length();
          var multipartFile = http.MultipartFile(
            'picture', // 백엔드에서 기대하는 필드 이름
            stream,
            length,
            filename: selectedImage.value!.path.split('/').last,
          );
          request.files.add(multipartFile);
        } catch (e) {
          print("이미지 파일 처리 중 오류 발생: $e");
          return false;
        }
      }

      // 요청 보내기
      var streamedResponse = await request.send();

      // 응답 처리
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData['data'] == null) {
          print("서버에서 'data' 필드가 비어 있습니다.");
          return false;
        }

        // user.value 업데이트
        try {
          user.value = User.fromJson(responseData['data']);
          if (user.value != null) {
            nicknameController.text = user.value!.nickname;
            phoneController.text = user.value!.phone;
            gender.value = user.value!.gender;
            ageGroup.value = user.value!.ageGroup;
            paybackMethod.value = user.value!.paybackMethod;
            referrerNicknameController.text = user.value!.referrerId.toString();
            await getReferrerInfo(user.value!.referrerId);
            await getReferredInfos(user.value!.id);
          }
          print("user.value 업데이트 완료: ${user.value?.toJson()}");
          return true;
        } catch (e) {
          print("User.fromJson에서 오류 발생: $e");
          return false;
        }
      } else {
        print("회원가입 실패: ${response.body}");
        return false;
      }
    } catch (error) {
      print("서버 요청 중 오류 발생: $error");
      return false;
    }
  }

  Future<void> checkNickname(String nickname) async {
    var url = '$baseUrl/api/user/check-nickname';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': nickname}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['isDuplicate'] == true) {
          nicknameErrTxt.value = "이미 사용중인 닉네임입니다.";
        } else {
          nicknameErrTxt.value = "";
          print("닉네임 사용 가능: ${responseData['message']}");
        }
      } else {
        nicknameErrTxt.value = "닉네임 확인 실패";
        print("닉네임 확인 실패: ${response.body}");
      }
    } catch (e) {
      nicknameErrTxt.value = "닉네임 확인 중 오류 발생";
      print("닉네임 확인 중 오류 발생: $e // $nickname");
    }
  }

  void showConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    child: Text(
                      "인증되었습니다.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                InkWell(
                  onTap: () {
                    Get.toNamed("/main");
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                      color: CatchmongColors.gray_300,
                    ))),
                    height: 60,
                    child: Text(
                      "확인",
                      style: TextStyle(
                        color: CatchmongColors.blue1,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void showNoConfirmDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.all(0),
          contentPadding: EdgeInsets.all(0),
          content: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 16,
                    ),
                    child: Text(
                      "인증번호가 일치하지 않습니다.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    )),
                InkWell(
                  onTap: () {
                    // 확인 버튼의 동작 추가
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                      color: CatchmongColors.gray_300,
                    ))),
                    height: 60,
                    child: Text(
                      "확인",
                      style: TextStyle(
                        color: CatchmongColors.blue1,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> checkReferrer(String referrerNickname) async {
    var url = '$baseUrl/api/user/check-referrer';
    try {
      if (referrerNickname.isEmpty) return;
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'referrerNickname': referrerNickname}),
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (responseData['exists'] == true) {
          print("추천인 유효: ${responseData['message']}");
          referrerNicknameErrTxt.value = "";
        } else {
          referrerNicknameErrTxt.value = "추천인이 유효하지 않습니다.";
        }
      } else {
        referrerNicknameErrTxt.value = "추천인 확인 실패";
        print("추천인 확인 실패: ${response.body}");
      }
    } catch (e) {
      referrerNicknameErrTxt.value = "추천인 확인 중 오류 발생";
      print("추천인 확인 중 오류 발생: $e");
    }
  }

  Future<void> checkPhone(String phone) async {
    try {
      if (phoneController.text.isEmpty) {
        phoneErrTxt.value = "폰번호를 입력해주세요";
      } else {
        phoneErrTxt.value = "";
      }
    } catch (e) {
      print("폰번호를 입력해주세요: $e");
    }
  }

  Future<void> checkAndGoVerti() async {
    // 저장 버튼 누르기 전에 1.닉네임 중복인지 2.추천인 유효한지 3. 텍스트필드 필수정보 모두 입력했는지 체크
    await checkNickname(nicknameController.text);
    await checkReferrer(referrerNicknameController.text);
    await checkPhone(phoneController.text);
    // 닉네임과 추천인 검증이 성공한 경우 추가 정보 등록 진행
    if (nicknameErrTxt.value.isEmpty &&
        referrerNicknameErrTxt.value.isEmpty &&
        phoneErrTxt.value.isEmpty) {
      Get.toNamed('/certi');
    } else {
      print("검증 실패: 닉네임 중복 또는 추천인 유효하지 않음");
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
          'sub': "o301s4dgmq", //auth[2],  // Google User ID (sub)
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
          await getReferrerInfo(user.value!.referrerId);
          await getReferredInfos(user.value!.id);
          update();
          print("구글 로그인 성공 추천인 목록: ${referreds} ");
          Get.toNamed("/main"); // 메인 페이지로 이동
        }
      } else {
        print("구글 로그인 실패: ${response.body}");
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
    }
  }

//내가 회원가입 시 추천한 추천인
  Future<void> getReferrerInfo(int? userId) async {
    final String url = '$baseUrl/api/user/referrer/$userId'; // API 엔드포인트

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['referrer'] != null) {
          referrer.value = Referrer.fromJson(data["referrer"]);
          print("내 추천인 ${referrer.value?.nickname}");
        } else {
          print("추천인 정보가 없습니다.");
        }
      } else if (response.statusCode == 404) {
        print("사용자 또는 추천인을 찾을 수 없습니다.");
      } else {
        print("오류 발생: ${response.body}");
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
    }
  }

  //나를 추천한 추천인 목록
  Future<void> getReferredInfos(int? userId) async {
    final String url = '$baseUrl/api/user/referred/$userId'; // API 엔드포인트

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final List<dynamic> referredUsers = data['referredUsers'];
        referreds.addAll(referredUsers.map((e) => Referrer.fromJson(e)));
      } else if (response.statusCode == 404) {
        print("사용자 또는 추천인을 찾을 수 없습니다.");
      } else {
        print("오류 발생: ${response.body}");
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
