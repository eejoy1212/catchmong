class User {
  final String email;
  final String name;
  final String? nickname;
  final String? picture;
  final String sub;

  User({
    required this.email,
    required this.name,
    this.nickname,
    this.picture,
    required this.sub,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String?,
      picture: json['picture'] as String?,
      sub: json['sub'] as String,
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'nickname': nickname,
      'picture': picture,
      'sub': sub,
    };
  }
}
