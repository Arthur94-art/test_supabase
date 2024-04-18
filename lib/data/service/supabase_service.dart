import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_supabase/data/models/email_model.dart';
import 'package:test_supabase/data/models/user_model.dart';
import 'package:test_supabase/data/supabase/collection_keys.dart';

abstract class SupaBaseService {
  Future<List<UserModel>> fetchUsers();
  Future<void> addUser({
    required String firstName,
    required String lastName,
    required String email,
  });
  Future<void> deleteUser(int userId);

  List<EmailDataModel> get emailList;

  void addEmailToList({
    required String name,
    required String lastName,
    required String email,
  });
}

class SupaBaseServiceImpl implements SupaBaseService {
  final SupabaseClient _client;
  final CollectionKeys _sbKeys;
  SupaBaseServiceImpl({
    required SupabaseClient client,
    required CollectionKeys sbKeys,
  })  : _sbKeys = sbKeys,
        _client = client;

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

  @override
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _client.from(_sbKeys.usersKey).select();
      final userList = response.map((e) => UserModel.fromJson(e)).toList();
      userList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return userList;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> addUser({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    try {
      var response = await _client.from(_sbKeys.usersKey).insert({
        _sbKeys.firstName: firstName,
        _sbKeys.lastName: lastName,
        _sbKeys.email: email,
        _sbKeys.createdAt: DateTime.now().toIso8601String(),
      }).select();
      return UserModel.fromJson(response.first);
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }

  @override
  Future<void> deleteUser(int userId) async {
    try {
      final response = await _client
          .from(_sbKeys.usersKey)
          .delete()
          .match({_sbKeys.id: userId});
      if (response != null) {
        throw Exception('Failed to delete user: $response');
      }
    } catch (e) {
      throw Exception('Failed to delete user: $e');
    }
  }
}
