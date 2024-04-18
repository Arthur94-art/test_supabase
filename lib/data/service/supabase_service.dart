import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
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
}

class SupaBaseServiceImpl implements SupaBaseService {
  final SupabaseClient _client;
  final CollectionKeys _sbKeys;
  SupaBaseServiceImpl({
    required SupabaseClient client,
    required CollectionKeys sbKeys,
  })  : _sbKeys = sbKeys,
        _client = client;

  @override
  Future<List<UserModel>> fetchUsers() async {
    try {
      final response = await _client.from(_sbKeys.usersKey).select();
      final userList = response.map((e) => UserModel.fromJson(e)).toList();
      userList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return userList;
    } catch (e) {
      log(e.toString());
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
      log(e.toString());
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
      log(e.toString());
      throw Exception('Failed to delete user: $e');
    }
  }
}



//re_LaU1h8Qv_GsTmgm7XuGnDXsphao5Dm3gA

