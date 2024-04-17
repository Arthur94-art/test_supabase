class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final String id;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      id: json['id'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'id': id,
    };
  }
}
