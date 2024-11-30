class Referrer {
  final String nickname;
  final String email;
  final String? picture;
  Referrer({
    required this.nickname,
    required this.email,
    this.picture,
  });

  // JSON에서 데이터를 파싱하기 위한 팩토리 생성자
  factory Referrer.fromJson(Map<String, dynamic> json) {
    return Referrer(
      nickname: json['nickname'] as String,
      email: json['email'] as String,
      picture: json['picture'] as String?,
    );
  }

  // JSON으로 변환하는 메서드
  Map<String, dynamic> toJson() {
    return {
      'nickname': nickname,
      'email': email,
      'picture': picture,
    };
  }
}
