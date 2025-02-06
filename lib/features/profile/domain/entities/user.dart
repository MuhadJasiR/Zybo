class User {
  final String name;
  final String phoneNumber;

  User({required this.name, required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      phoneNumber: json["phone_number"],
    );
  }
}
