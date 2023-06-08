class CustomUser {
  CustomUser({
    required this.username,
    required this.token,
  });

  String? username;
  String? token;

  factory CustomUser.fromJson(Map<String, dynamic> json) => CustomUser(
        username: json['username'] as String,
        token: json['token'] as String,
      );

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "token": token,
      };
}
