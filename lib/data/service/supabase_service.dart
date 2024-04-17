import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:test_supabase/data/models/user_model.dart';
import 'package:test_supabase/data/supabase/collection_keys.dart';

abstract class SupaBaseService {
  Future<List<UserModel>> fetchUsers();
  Future<void> addUser(UserModel user);
  Future<void> deleteUser(String userId);
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
      return response.map((e) => UserModel.fromJson(e)).toList();
    } catch (e) {
      log(e.toString());
      throw Exception(e);
    }
  }

  @override
  Future<void> addUser(UserModel user) async {
    try {
      final response =
          await _client.from(_sbKeys.usersKey).insert(user.toJson());
      if (response != null) {
        throw Exception('Failed to add user: $response');
      }
    } catch (e) {
      log(e.toString());
      throw Exception('Failed to add user: $e');
    }
  }

  @override
  Future<void> deleteUser(String userId) async {
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
