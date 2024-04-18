class EmailDataModel {
  final String firstName;
  final String lastName;
  final String email;
  EmailDataModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });
  factory EmailDataModel.fromJson(Map<String, dynamic> json) {
    return EmailDataModel(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}
