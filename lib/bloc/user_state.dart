part of 'user_bloc.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadedState extends UserState {
  final List<UserModel> userList;
  UserLoadedState({required this.userList});
}

class UserFailureState extends UserState {}
