part of 'user_bloc.dart';

abstract class UserEvent {}

class UserFetchEvent extends UserEvent {}

class UserAddEvent extends UserEvent {
  final UserModel user;
  UserAddEvent({required this.user});
}

class UserDeleteEvent extends UserEvent {
  final String id;
  UserDeleteEvent({required this.id});
}
