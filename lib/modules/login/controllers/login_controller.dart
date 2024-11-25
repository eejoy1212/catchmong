import 'dart:async';
import 'dart:convert';
import 'package:catchmong/services/user_service.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  // 이미지 표시 여부를 관리하는 반응형 변수
  var showLatestLoginImage = true.obs;
  var users = <dynamic>[].obs;
  var isLoading = false.obs;
  final String baseUrl = 'http://192.168.200.102:3000';
  final UserService userService = UserService();

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
      print("url>>>${url}");
      print("구글 로그인 ??>>>${response.statusCode} // ${idToken}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body);
        print("구글 로그인 성공: ${responseData['user']}");
        Get.toNamed("/signup");
        // 여기서 추가 정보 입력 화면으로 이동
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
