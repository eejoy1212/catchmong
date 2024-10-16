import 'package:catchmong/const/catchmong_colors.dart';
import 'package:flutter/material.dart';

class UseDialog extends StatelessWidget {
  const UseDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            "이용약관",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.close,
                size: 24,
                color: CatchmongColors.gray400,
              ),
            ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Text(
          "제1장 총칙\n\n"
          "제1조(목적)\n"
          "본 약관은 정부24 (이하 '당 사이트')가 제공하는 모든 서비스(이하 '서비스')의 이용조건 및 절차, 이용자와 당 사이트의 권리, 의무, 책임사항과 기타 필요한 사항을 규정함을 목적으로 합니다.\n\n"
          "제2조(용어의 정의)\n"
          "본 약관에서 사용하는 용어의 정의는 다음과 같습니다.\n\n"
          "① 이용자 : 본 약관에 따라 당 사이트가 제공하는 서비스를 이용할 수 있는 자.\n"
          "② 가입 : 당 사이트가 제공하는 신청서 양식에 해당 정보를 기입하고, 본 약관에 동의하여 서비스 이용계약을 완료시키는 행위\n"
          "③ 회원 : 당 사이트에 개인정보 등 관련 정보를 제공하여 회원등록을 한 개인(재외국민, 국내거주 외국인 포함)또는 법인으로서 당 사이트의 정보를 제공 받으며, 당 사이트가 제공하는 서비스를 이용할 수 있는 자.\n"
          "④ 아이디(ID) : 회원의 식별과 서비스 이용을 위하여 회원이 문자와 숫자의 조합으로 설정한 고유의 체계\n"
          "⑤ 비밀번호 : 이용자와 아이디가 일치하는지를 확인하고 통신상의 자신의 비밀보호를 위하여 이용자 자신이 선정한 문자와 숫자의 조합.\n"
          "⑥ 탈퇴 : 회원이 이용계약을 종료 시키는 행위\n"
          "⑦ 본 약관에서 정의하지 않은 용어는 개별서비스에 대한 별도 약관 및 이용규정에서 정의하거나 일반적인 개념에 의합니다.\n\n"
          "제3조(약관의 효력과 변경)\n"
          "① 당 사이트는 귀하가 본 약관 내용에 동의하는 것을 조건으로 귀하에게 서비스를 제공할 것이며, 귀하가 본 약관의 내용에 동의하는 경우, 당 사이트의 서비스 제공 행위 및 귀하의 서비스 사용 행위에는 본 약관이 우선적으로 적용됩니다.\n"
          "② 당 사이트는 본 약관을 변경할 수 있으며, 변경된 약관은 당 사이트 내에 공지함으로써 이용자가 직접 확인하도록 할 것입니다. 약관을 변경할 경우에는 적용일자 및 변경사유를 명시하여 당 사이트 내에 그 적용일자 30일 전부터 공지합니다. 약관 변경 공지 후 이용자가 명시적으로 약관 변경에 대한 거부의사를 표시하지 아니하면, 이용자가 약관에 동의한 것으로 간주합니다. 이용자가 변경된 약관에 동의하지 아니하는 경우, 이용자는 본인의 회원등록을 취소(회원탈퇴)할 수 있습니다.\n\n"
          "제4조(약관외 준칙)\n"
          "① 본 약관은 당 사이트가 제공하는 서비스에 관한 이용규정 및 별도 약관과 함께 적용됩니다.\n"
          "② 본 약관에 명시되지 않은 사항은 정보통신망 이용촉진 및 정보보호 등에 관한 법률, 전기통신기본법, 전기통신사업법, 정보통신윤리위원회심의규정, 정보통신 윤리강령, 프로그램보호법 등 관계법령과 개인정보 처리방침 및 행정안전부가 별도로 정한 지침 등의 규정에 따릅니다.\n\n"
          "제5조(회원정보의 통합관리)\n"
          "당 사이트의 회원정보는 행정기관 타 사이트의 회원정보와 통합하여 관리될 수 있습니다.\n",
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
