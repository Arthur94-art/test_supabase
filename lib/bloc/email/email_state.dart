part of 'email_bloc.dart';

abstract class EmailState {}

class EmailInitialState extends EmailState {}

class EmailSendSuccesfullState extends EmailState {}

class EmailListState extends EmailState {
  final List<EmailDataModel> emailList;
  EmailListState({required this.emailList});
}

class EmailFailureState extends EmailState {}
