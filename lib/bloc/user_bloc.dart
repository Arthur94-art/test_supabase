import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_supabase/data/di/service_locator.dart';
import 'package:test_supabase/data/models/user_model.dart';
import 'package:test_supabase/data/service/supabase_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SupaBaseServiceImpl _sbService = locator<SupaBaseServiceImpl>();
  UserBloc() : super(UserInitialState()) {
    on<UserFetchEvent>((event, emit) async {
      try {
        final List<UserModel> userList = await _sbService.fetchUsers();
        emit(UserLoadedState(userList: userList));
      } catch (_) {
        emit(UserFailureState());
      }
    });
  }
}
