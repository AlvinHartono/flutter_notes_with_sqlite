class User {
  final int? userId;
  final String username;
  String password;

  User({
    this.userId,
    required this.username,
    required this.password,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
        userId: json["userId"],
        username: json["username"],
        password: json["password"],
      );

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "username": username,
        "password": password,
      };
}
