// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_bloc.dart';

abstract class UserEvent {}

class UserFetchEvent extends UserEvent {}

class UserAddEvent extends UserEvent {
  final String name;
  final String lastName;
  final String email;
  UserAddEvent({
    required this.name,
    required this.lastName,
    required this.email,
  });
}

class UserDeleteEvent extends UserEvent {
  final int id;
  UserDeleteEvent({required this.id});
}

class AddEmailToListEvent extends UserEvent {
  final String name;
  final String lastName;
  final String email;
  AddEmailToListEvent({
    required this.email,
    required this.name,
    required this.lastName,
  });
}

class SendOnUserEmailEvent extends UserEvent {}
