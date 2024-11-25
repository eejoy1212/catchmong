import 'dart:convert'; // JSON 디코딩
import 'package:http/http.dart' as http;

class UserService {
  // 서버 주소
  final String baseUrl = 'http://192.168.200.102:3000';

  // 사용자 목록 가져오기
  Future<String> fetchUsers() async {
    final url = Uri.parse('$baseUrl');

    try {
      final response = await http.get(url);
      print("res>>> ${response.body}");
      if (response.statusCode == 200) {
        // JSON 데이터를 파싱하여 리스트로 반환

        return response.body.toString();
      } else {
        throw Exception('[GET]백앤드 테스트 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('[GET]백앤드 테스트 실패: $e');
      throw Exception('Failed to fetch users');
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
        // 여기서 추가 정보 입력 화면으로 이동
      } else {
        print("구글 로그인 실패: ${response.body}");
      }
    } catch (e) {
      print("서버 요청 중 오류 발생: $e");
    }
  }
}
