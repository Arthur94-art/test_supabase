import 'package:intl/intl.dart';

class UserModel {
  final String firstName;
  final String lastName;
  final String email;
  final int id;
  final DateTime createdAt;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.id,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      id: json['id'] as int,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'id': id,
      'created_at': DateFormat('yyyy-MM-ddTHH:mm:ss').format(createdAt),
    };
  }
}
