import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_supabase/data/di/service_locator.dart';
import 'package:test_supabase/data/models/email_model.dart';
import 'package:test_supabase/data/service/email_service.dart';
import 'package:test_supabase/data/service/user_service.dart';

part 'email_event.dart';
part 'email_state.dart';

class EmailBloc extends Bloc<EmailEvent, EmailState> {
  final UserServiceImpl _userService = locator<UserServiceImpl>();
  final EmailServiceImpl _emailService = locator<EmailServiceImpl>();

  EmailBloc() : super(EmailInitialState()) {
    on<AddEmailToListEvent>((event, emit) async {
      _userService.addEmailToList(
          name: event.name, lastName: event.lastName, email: event.email);
      emit(EmailListState(emailList: _userService.emailList));
    });
    on<SendOnUserEmailEvent>((event, emit) async {
      try {
        await _emailService.sendEmails(_userService.emailList);
      } catch (_) {
        emit(EmailFailureState());
      }
    });
  }
}
