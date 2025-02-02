import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:catchmong/const/catchmong_colors.dart';
import 'package:catchmong/const/constant.dart';
import 'package:catchmong/model/catchmong_user.dart';
import 'package:catchmong/model/partner.dart';
import 'package:catchmong/model/referrer.dart';
import 'package:catchmong/services/user_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class LoginController extends GetxController {
  // 이미지 표시 여부를 관리하는 반응형 변수
  final UserService userService = UserService();

  // late WebSocketChannel _channel;
  final channel = WebSocketChannel.connect(Uri.parse("ws://$myPort:4000"));
  RxList<int> onlineUsers = <int>[].obs; // 온라인 유저 목록 (RxList)
  RxBool isOnline = false.obs; // 현재 유저의 온라인 상태
  var showLatestLoginImage = true.obs;
  var users = <dynamic>[].obs;
  var isLoading = false.obs;
  final String baseUrl = 'http://$myPort:3000';
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
  final TextEditingController bankAccountController = TextEditingController();
  RxString bankName = "신한은행".obs;
  RxList<Partner> scrapedPartners = RxList.empty();
  // 타이머 관련 변수
  RxInt remainingSeconds = 600.obs; // 10분 (600초)
  Timer? countdownTimer;
  RxBool isVerified = false.obs; // 인증 성공 여부
  RxBool isBankVertified = false.obs;
  RxInt generatedCode = RxInt(0); // 서버에서 생성된 인증번호 저장

  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'http://$myPort:3000', // API 베이스 URL
    connectTimeout: const Duration(milliseconds: 5000), // 연결 제한 시간
    receiveTimeout: const Duration(milliseconds: 3000), // 응답 제한 시간
  ));

  @override
  void onInit() async {
    super.onInit();
    // temp();
    // kakaoLogoutTest();
    loadBackEndCheck();
    checkAutoLogin();
    await connect();
    print("now user>>> ${user.value?.email}");

    // 5초 후에 이미지 표시를 중단합니다.
    Timer(Duration(seconds: 5), () {
      showLatestLoginImage.value = false;
    });
  }

  // void temp() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('sub', "");
  //   await prefs.setString('loginType', "");
  //   await prefs.setString('accessToken', "");
  //   await prefs.setString('refreshToken', "");
  // }

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
  //모든지역에 해당하는 파트너 가져오는 함수 알려줘

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

  String getAgeType(String value) {
    switch (value) {
      case "10대":
        return "TEN";
      case "20대":
        return "TWENTY";
      case "30대":
        return "THIRTY";
      case "40대":
        return "FORTY";
      case "50대":
        return "FIFTY";
      case "60대":
        return "SIXTY";
      case "70대+":
        return "SEVENTY_PLUS";
      default:
        return "TEN";
    }
  }

  String getAgeTypeByBe(String value) {
    switch (value) {
      case "TEN":
        return "10대";
      case "TWENTY":
        return "20대";
      case "THIRTY":
        return "30대";
      case "FORTY":
        return "40대";
      case "FIFTY":
        return "50대";
      case "SIXTY":
        return "60대";
      case "SEVENTY_PLUS":
        return "70대+";
      default:
        return "10대";
    }
  }

//인증하기 후 최종 회원가입
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
      request.fields['ageGroup'] = getAgeType(ageGroup.value);
      request.fields['bankName'] = bankName.value;
      request.fields['bankAccount'] = bankAccountController.text;

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
            ageGroup.value = getAgeTypeByBe(user.value!.ageGroup);
            paybackMethod.value = user.value!.paybackMethod;
            referrerNicknameController.text = referrerNicknameController.text;
            // if (user.value!.picture != null) {
            //   selectedImage.value = File("${baseUrl}${user.value!.picture!}");
            // }
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

  Future<void> checkNicknameForUpdate(
      String currentNickname, String newNickname) async {
    var url = '$baseUrl/api/user/check-nickname';
    try {
      if (currentNickname == newNickname) {
        // 기존 닉네임과 같으면 중복 체크 필요 없음
        nicknameErrTxt.value = "";
        print("닉네임 변경 없음: $newNickname");
        return;
      }

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'nickname': newNickname}),
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
      print("닉네임 확인 중 오류 발생: $e");
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

  // void showConfirmDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         titlePadding: EdgeInsets.all(0),
  //         contentPadding: EdgeInsets.all(0),
  //         content: SizedBox(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                   padding: EdgeInsets.symmetric(
  //                     vertical: 20,
  //                     horizontal: 16,
  //                   ),
  //                   child: Text(
  //                     "인증되었습니다.",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontSize: 17,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   )),
  //               InkWell(
  //                 onTap: () {
  //                   Get.toNamed("/main");
  //                 },
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       border: Border(
  //                           top: BorderSide(
  //                     color: CatchmongColors.gray_300,
  //                   ))),
  //                   height: 60,
  //                   child: Text(
  //                     "확인",
  //                     style: TextStyle(
  //                       color: CatchmongColors.blue1,
  //                       fontSize: 17,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void showNoConfirmDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Colors.white,
  //         titlePadding: EdgeInsets.all(0),
  //         contentPadding: EdgeInsets.all(0),
  //         content: SizedBox(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             children: [
  //               Container(
  //                   padding: EdgeInsets.symmetric(
  //                     vertical: 20,
  //                     horizontal: 16,
  //                   ),
  //                   child: Text(
  //                     "인증번호가 일치하지 않습니다.",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontSize: 17,
  //                       fontWeight: FontWeight.w400,
  //                     ),
  //                   )),
  //               InkWell(
  //                 onTap: () {
  //                   // 확인 버튼의 동작 추가
  //                   Get.back();
  //                 },
  //                 child: Container(
  //                   alignment: Alignment.center,
  //                   decoration: BoxDecoration(
  //                       border: Border(
  //                           top: BorderSide(
  //                     color: CatchmongColors.gray_300,
  //                   ))),
  //                   height: 60,
  //                   child: Text(
  //                     "확인",
  //                     style: TextStyle(
  //                       color: CatchmongColors.blue1,
  //                       fontSize: 17,
  //                       fontWeight: FontWeight.w600,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  Future<void> checkReferrer(String referrerNickname) async {
    var url = '$baseUrl/api/check-referrer';
    try {
      print("000res>>>${referrerNickname}");
      if (referrerNickname.isEmpty) return;

      final response = await _dio.post(
        url,
        data: {
          'referrerNickname': referrerNickname,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      print("res>>>${response.data}");
      // 응답 데이터 처리
      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData['exists'] == true) {
          print("추천인 유효: ${responseData['message']}");
          referrerNicknameErrTxt.value = "";
        } else {
          referrerNicknameErrTxt.value = "추천인이 유효하지 않습니다.";
        }
      } else {
        referrerNicknameErrTxt.value = "추천인 확인 실패";
        print("추천인 확인 실패: ${response.data}");
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

  Future<void> checkUpdateUserAndGoVerti() async {
    if (isBankVertified.isFalse) return;
    await checkNicknameForUpdate(user.value!.nickname, nicknameController.text);
    await checkReferrer(referrerNicknameController.text);
    await checkPhone(phoneController.text);

    if (nicknameErrTxt.value.isEmpty &&
        referrerNicknameErrTxt.value.isEmpty &&
        phoneErrTxt.value.isEmpty) {
      Get.toNamed('/certi');
    } else {
      print("검증 실패: 닉네임 중복 또는 추천인 유효하지 않음");
    }
  }

  Future<void> checkAndGoVerti() async {
    if (isBankVertified.isFalse) return;
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
    final String url = '$baseUrl/api/send-verification';
    final String phone = phoneController.text;

    print("phone send code>>> $phone");

    if (phone.isEmpty) {
      print('전화번호가 입력되지 않았습니다.');
      return;
    }

    try {
      // Dio 요청
      final response = await _dio.post(
        url,
        data: {
          'phone': phone, // 요청에 전달할 데이터
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json', // 헤더 설정
          },
        ),
      );

      // 상태 코드 확인
      if (response.statusCode == 200) {
        final responseData = response.data;
        final code = responseData["data"];
        print("인증번호 전송 성공: ${responseData['message']}");
        vertiCodeController.text = code.toString(); // 인증번호 자동 입력
        generatedCode.value = code; // 인증번호 저장
        startTimer(); // 타이머 시작
      } else {
        print("인증번호 전송 실패: ${response.data['error'] ?? response.data}");
      }
    } catch (e) {
      if (e is DioError) {
        print(
            "서버 요청 중 Dio 오류 발생: ${e.response?.data ?? e.message}"); // Dio 오류 처리
      } else {
        print("서버 요청 중 오류 발생: $e");
      }
    }
  }

  Future<void> verifyCode() async {
    final String url = '$baseUrl/api/verify-code';

    try {
      // POST 요청을 보냄
      final response = await _dio.post(
        url,
        data: {
          'phone': phoneController.text,
          'code': vertiCodeController.text,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      // 상태 코드 확인
      if (response.statusCode == 200) {
        isVerified.value = true;
        print('인증 성공');
      } else {
        isVerified.value = false;
        print('인증 실패: ${response.data}');
      }
    } catch (e) {
      if (e is DioError) {
        // DioError의 에러 메시지 출력
        print('인증 중 오류 발생: ${e.response?.data ?? e.message}');
      } else {
        print('인증 중 알 수 없는 오류 발생: $e');
      }
      isVerified.value = false;
    }
  }

  Future<bool> updateUser() async {
    final success = await updateUserInfo(
      userId: user.value!.id, // 수정할 사용자 ID
      newNickname: nicknameController.text,
      newPhone: phoneController.text,
      newGender: gender.value,
      newAgeGroup: ageGroup.value,
      newPaybackMethod: paybackMethod.value,
      newReferrerNickname: referrerNicknameController.text,
      pictureFile: selectedImage.value, // 선택적으로 이미지 파일
    );

    if (success) {
      print("회원정보 수정 성공");

      return true;
    } else {
      print("회원정보 수정 실패");
      return false;
    }
  }

  Future<bool> updateUserInfo({
    required int userId,
    String? newNickname,
    String? newPhone,
    String? newGender,
    String? newPaybackMethod,
    String? newAgeGroup,
    String? newReferrerNickname, // 추천인 닉네임
    File? pictureFile,
  }) async {
    final String url = '$baseUrl/api/user-update/$userId';

    try {
      // MultipartRequest 생성
      var request = http.MultipartRequest('PUT', Uri.parse(url));

      // JSON 데이터 추가 (선택적)
      if (newNickname != null) request.fields['nickname'] = newNickname;
      if (newPhone != null) request.fields['phone'] = newPhone;
      if (newGender != null) request.fields['gender'] = newGender;
      if (newPaybackMethod != null)
        request.fields['paybackMethod'] = newPaybackMethod;
      if (newAgeGroup != null)
        request.fields['ageGroup'] = getAgeType(newAgeGroup);
      if (newReferrerNickname != null)
        request.fields['referrerNickname'] = newReferrerNickname;

      // 이미지 파일 추가 (선택적)
      if (pictureFile != null) {
        var stream = http.ByteStream(pictureFile.openRead());
        var length = await pictureFile.length();
        var multipartFile = http.MultipartFile(
          'picture',
          stream,
          length,
          filename: pictureFile.path.split('/').last,
        );
        request.files.add(multipartFile);
      }
      print(
          "req send before>>>>>>>>>>>>>>>>>>>${getAgeType(newAgeGroup ?? "10대")}");
      // 요청 보내기
      var streamedResponse = await request.send();

      // 응답 처리
      var response = await http.Response.fromStream(streamedResponse);
      print("회원정보 수정 res>>>${jsonDecode(response.body)}");
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        user.value = User.fromJson(responseData['data']);
        if (user.value != null) {
          nicknameController.text = user.value!.nickname;
          phoneController.text = user.value!.phone;
          gender.value = user.value!.gender;
          ageGroup.value = getAgeType(user.value!.ageGroup);
          paybackMethod.value = user.value!.paybackMethod;
          referrerNicknameController.text = user.value!.referrerId.toString();
          // if (user.value!.picture != null) {
          //   selectedImage.value = File("${baseUrl}${user.value!.picture!}");
          // }
          //임시로 주석처리
          // await getReferrerInfo(user.value!.referrerId);
          // await getReferredInfos(user.value!.id);
        }
        print("회원정보 수정 성공: ${response.body}");
        user.value = User.fromJson(responseData["data"]);
        return true;
      } else {
        print("회원정보 수정 실패: ${response.body}");
        return false;
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
      return false;
    }
  }

////카카오 로그인 연습
  Future<void> kakaoLoginTest() async {
    try {
      // 카카오톡 앱으로 로그인 시도
      if (await kakao.isKakaoTalkInstalled()) {
        await kakao.UserApi.instance.loginWithKakaoTalk();
      } else {
        // 카카오 계정으로 로그인
        await kakao.UserApi.instance.loginWithKakaoAccount();
      }

      // 사용자 정보 가져오기
      final kakaoUser = await kakao.UserApi.instance.me();
      print('[테스트]카카오 사용자 정보: ${kakaoUser.kakaoAccount?.email}');
      // isLoggedIn = true;
    } catch (error) {
      print('[테스트]카카오 로그인 실패: $error');
    }
  }

  Future<void> logout() async {
    try {
      await kakao.UserApi.instance.logout();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("sub");
      await prefs.remove("loginType");
      await prefs.remove("accessToken");
      await prefs.remove("refreshToken");
      Get.offAndToNamed("/login");
      print('[테스트]로그아웃 성공');
      // isLoggedIn = false;
    } catch (error) {
      print('[테스트]로그아웃 실패: $error');
    }
  }

////카카오 로그인 연습
  Future<void> loginWithKakao() async {
    try {
      // 1. 카카오톡 설치 여부 확인 후 로그인
      if (await kakao.isKakaoTalkInstalled()) {
        await kakao.UserApi.instance.loginWithKakaoTalk();
      } else {
        await kakao.UserApi.instance.loginWithKakaoAccount();
      }

      // 2. 로그인 성공 시 사용자 정보 가져오기
      final nowKakaoUser = await kakao.UserApi.instance.me();
      print('카카오 로그인 성공, 사용자 정보: ${user}');

      // 3. 액세스 토큰 및 리프레시 토큰 가져오기
      final token = await kakao.AuthApi.instance.refreshToken();
      final kakaoUser = await kakao.UserApi.instance.me();
      final accessToken = token.accessToken; // null 가능성 처리
      final refreshToken = token.refreshToken;
      final sub = kakaoUser.id.toString();
      final bySubResponse = await fetchUserBySub(sub);

      if (refreshToken != null) {
        print('액세스 토큰: $accessToken');
        print('리프레시 토큰: $refreshToken');

        // 갱신된 토큰을 로컬에 저장
        await _saveUpdatedToken(accessToken, refreshToken);

        // 서버에 사용자 정보 전달
        final response =
            await postLogin(nowKakaoUser.id.toString(), "kakao", accessToken);

        if (response['path'] == '/main') {
          // 기존 회원: 사용자 정보 로컬 저장 및 메인 이동
          user.value = User.fromJson(bySubResponse!);
          if (user.value != null) {
            nicknameController.text = user.value!.nickname;
            phoneController.text = user.value!.phone;
            gender.value = user.value!.gender;
            ageGroup.value = getAgeTypeByBe(user.value!.ageGroup);
            paybackMethod.value = user.value!.paybackMethod;
            referrerNicknameController.text = user.value!.referrerId.toString();
          }

          await _saveLoginInfo(
              nowKakaoUser.id.toString(), 'kakao', accessToken, refreshToken);

          print('카카오 로그인 성공, 사용자 ID: $sub');

          // 3. 서버에 사용자 정보 전달

          Get.offAndToNamed('/location');
        } else if (response['path'] == '/signup') {
          // 신규 회원: 추가 정보 입력 페이지 이동
          Get.offAndToNamed('/signup', arguments: {
            'sub': nowKakaoUser.id.toString(),
            'loginType': 'kakao',
          });
        }
      } else {
        print('토큰을 가져오는 데 실패했습니다.');
        throw Exception('토큰 가져오기 실패');
      }
    } catch (e) {
      print('카카오 로그인 실패: $e');
    }
  }

  Future<Map<String, dynamic>?> fetchUserBySub(String sub) async {
    try {
      final response = await _dio.post(
        '/api/get-user-by-sub',
        data: {
          'sub': sub,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['data']; // 유저 정보 반환
      } else if (response.statusCode == 404) {
        print("유저 정보 없음: ${response.data['error']}");
        return null;
      } else {
        print("서버 오류: ${response.data}");
        return null;
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
      return null;
    }
  }

// 토큰 갱신 로직
  Future<void> refreshToken() async {
    try {
      // 토큰 유효성 검사
      final isTokenValid = await kakao.AuthApi.instance.hasToken();

      if (!isTokenValid) {
        // 토큰 갱신
        final token = await kakao.AuthApi.instance.refreshToken();
        print("토큰 갱신 성공: ${token.accessToken}");

        // 갱신된 토큰 저장
        await _saveUpdatedToken(token.accessToken, token.refreshToken ?? '');
      } else {
        // SharedPreferences 인스턴스 생성
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        // 'sub' 값 가져오기
        final String? sub = prefs.getString('sub');
        print("토큰이 여전히 유효합니다. ${sub} // ${user.value?.id}");
      }
    } catch (e) {
      print("토큰 갱신 실패: $e");
      // 갱신 실패 시 재로그인 요구
      await loginWithKakao();
    }
  }

// 토큰 저장 함수
  Future<void> _saveLoginInfo(String sub, String loginType, String accessToken,
      String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sub', sub);
    await prefs.setString('loginType', loginType);
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
    print(
      "로그인 정보 저장 완료$sub",
    );
  }

// 갱신된 토큰 저장
  Future<void> _saveUpdatedToken(
      String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    if (refreshToken != null) {
      await prefs.setString('refreshToken', refreshToken);
    }
  }

// 자동 로그인 처리
  Future<void> checkAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final sub = prefs.getString('sub');
    final loginType = prefs.getString('loginType');
    final accessToken = prefs.getString('accessToken');

    if (sub != null && loginType != null && accessToken != null) {
      try {
        print("자동 로그인 중... 사용자 ID: $sub, 로그인 타입: $loginType // $accessToken");
        final bySubResponse = await fetchUserBySub(sub);
        print("자동로그인 by sub>>>>>>>>>>>>>>>>>>>>>>${bySubResponse}");
        // 토큰 유효성 검사 및 갱신
        await refreshToken();

        // 서버에서 사용자 정보 확인
        final response = await postLogin(sub, loginType, accessToken);
        if (response['path'] == '/main') {
          // 자동 로그인 성공: 메인 화면으로 이동
          if (bySubResponse != null) {
            user.value = User.fromJson(bySubResponse);
            if (user.value != null) {
              setUserOnline(user.value!.id);
            }

            nicknameController.text = user.value!.nickname;
            phoneController.text = user.value!.phone;
            gender.value = user.value!.gender;
            ageGroup.value = getAgeTypeByBe(user.value!.ageGroup);
            paybackMethod.value = user.value!.paybackMethod;
            referrerNicknameController.text = user.value!.referrerId.toString();
            Get.offAndToNamed('/location');
          }
        } else {
          print("자동 로그인 실패: 사용자 정보가 일치하지 않습니다.");
          // Get.toNamed('/login');
        }
      } catch (e) {
        print("자동 로그인 실패: $e");
        // Get.toNamed('/login');
      }
    } else {
      print("저장된 로그인 정보가 없습니다.");
      // Get.toNamed('/login');
    }
  }

  Future<Map<String, dynamic>> postLogin(
      String sub, String loginType, String accessToken) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {
          'sub': sub,
          'loginType': loginType,
          'accessToken': accessToken, // 서버에 토큰 전달
        },
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        print("로그인 실패: ${response.data}");
        return {'path': '/signup'};
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
      return {'path': '/login'};
    }
  }

  Future<void> fetchScrapedPartners() async {
    try {
      final response = await _dio.get(
        baseUrl + "/api/my-scrap",
        queryParameters: {'userId': user.value!.id}, // 쿼리 파라미터
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data["data"];
        List<Partner> scraped = data
            .map((json) => Partner.fromJson(json as Map<String, dynamic>))
            .toList();
        scrapedPartners.value = scraped;
      } else {
        throw Exception('Failed to fetch scraped partners');
      }
    } catch (e) {
      throw Exception('Error fetching scraped partners: $e');
    }
  }

//////////////
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
          if (referrer.value != null) {
            referrerNicknameController.text = referrer.value!.nickname;
          }

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
    referreds.clear();
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
  Future<void> loadBackEndCheck() async {
    try {
      print("load BackEnd Check");
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
    if (user.value != null) {
      // 컨트롤러가 제거될 때 WebSocket 연결 해제
      disconnect(user.value!.id);
    }
  }
  //////////////////////////

  // WebSocket 서버에 연결
  Future<void> connect() async {
    // 서버로부터 메시지 수신
    print("_channel>>>$channel");
    await channel.ready;
    channel.stream.listen((message) {
      final data = jsonDecode(message);

      // 온라인 유저 목록 업데이트
      if (data['isOnline'] == true) {
        onlineUsers.assignAll(List<int>.from(data['users']));
        print("온라인 유저 목록 업데이트: ${onlineUsers}");
      }
    }, onError: (error) {
      print("WebSocket 에러 발생: $error");
      isOnline.value = false; // 연결 실패 시 상태 변경
    }, onDone: () {
      print("WebSocket 연결 종료");
      isOnline.value = false; // 연결 종료 시 상태 변경
    });
  }

  void setUserOnline(int userId) {
    try {
      final message = jsonEncode({
        "type": "setOnline", // 명시적으로 상태 변경 타입 지정
        "isOnline": true,
        "userId": userId,
      });

      // 서버로 메시지 전송
      channel.sink.add(message);

      // 현재 유저의 온라인 상태 로컬 업데이트
      isOnline.value = true;
      print("유저 $userId 온라인 상태로 전환됨");
    } catch (e) {
      print("유저 $userId 온라인 상태 전환 중 오류 발생: $e");
    }
  }

  void setUserOffline(int userId) {
    try {
      final message = jsonEncode({
        "type": "setStatus", // 명시적으로 상태 변경 타입 지정
        "isOnline": false,
        "userId": userId,
      });

      // 서버로 메시지 전송
      channel.sink.add(message);

      // 현재 유저의 오프라인 상태 로컬 업데이트
      isOnline.value = false;
      print("유저 $userId 오프라인 상태로 전환됨");
    } catch (e) {
      print("유저 $userId 오프라인 상태 전환 중 오류 발생: $e");
    }
  }

  // WebSocket 연결 해제
  void disconnect(int userId) {
    if (isOnline.value) {
      // 연결 해제 전에 유저를 오프라인 상태로 설정
      setUserOffline(userId); // yourUserId를 실제 유저 ID로 대체
    }
    channel.sink.close(status.goingAway);
  }
}
