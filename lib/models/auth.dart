class UserAuth {
  final String username;
  final String password;

  UserAuth({required this.username, required this.password});

  Map<String, dynamic> toJson() {
    return {"Username": username, "Password": password};
  }
}
