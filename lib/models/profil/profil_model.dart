class UserModel {
  final String message;
  final UserData result;

  UserModel({required this.message, required this.result});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      result: UserData.fromJson(json['result']),
    );
  }
}

class UserData {
  final String name;
  final String role;
  final String email;
  final bool emailVerification;
  final String gender;

  UserData({
    required this.name,
    required this.role,
    required this.email,
    required this.emailVerification,
    required this.gender,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      role: json['role'],
      email: json['email'],
      emailVerification: json['email_verif'],
      gender: json['gender'],
    );
  }
}
