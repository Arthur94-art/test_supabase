part of 'email_bloc.dart';

abstract class EmailEvent {}

class AddEmailToListEvent extends EmailEvent {
  final String name;
  final String lastName;
  final String email;
  AddEmailToListEvent({
    required this.email,
    required this.name,
    required this.lastName,
  });
}

class SendOnUserEmailEvent extends EmailEvent {}
