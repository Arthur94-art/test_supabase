import 'package:test_supabase/data/models/email_model.dart';

abstract class UserService {
  void addEmailToList({
    required String name,
    required String lastName,
    required String email,
  });
  List<EmailDataModel> get emailList;
}

class UserServiceImpl implements UserService {
  static final UserServiceImpl _instance = UserServiceImpl._internal();

  factory UserServiceImpl() {
    return _instance;
  }

  UserServiceImpl._internal();

  final List<EmailDataModel> _emailList = [];

  @override
  List<EmailDataModel> get emailList => _emailList;

  @override
  void addEmailToList({
    required String name,
    required String lastName,
    required String email,
  }) {
    final EmailDataModel emailData =
        EmailDataModel(firstName: name, lastName: lastName, email: email);
    final existingUserIndex = _emailList.indexWhere((u) => u.email == email);
    if (existingUserIndex == -1) {
      _emailList.add(emailData);
    } else {
      _emailList.removeAt(existingUserIndex);
    }
  }
}
