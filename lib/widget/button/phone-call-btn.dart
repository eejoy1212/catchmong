import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PhoneCallBtn extends StatelessWidget {
  final String phoneNumber = "010-2222-1212";

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      // 에러 처리를 할 수 있습니다.
      print("전화 연결 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/tel-icon.png'),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () => _makePhoneCall(phoneNumber), // 전화걸기 함수 연결
          child: Text(
            phoneNumber,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            style: TextStyle(
              color: Colors.blue, // 전화번호에 색상 추가하여 클릭 가능하게 보이도록 설정
              decoration: TextDecoration.underline, // 밑줄 추가
            ),
          ),
        ),
      ],
    );
  }
}
