import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_supabase/data/di/service_locator.dart';
import 'package:test_supabase/data/models/user_model.dart';
import 'package:test_supabase/data/service/supabase_service.dart';
import 'package:test_supabase/data/service/user_service.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final SupaBaseServiceImpl _sbService = locator<SupaBaseServiceImpl>();
  final UserServiceImpl _userService = locator<UserServiceImpl>();
  UserBloc() : super(UserInitialState()) {
    on<UserFetchEvent>((event, emit) async {
      emit(UserInitialState());
      try {
        final List<UserModel> userList = await _sbService.fetchUsers();
        emit(UserLoadedState(userList: userList));
      } catch (_) {
        emit(UserFailureState());
      }
    });
    on<UserAddEvent>((event, emit) async {
      try {
        final UserModel newUser = await _sbService.addUser(
          firstName: event.name,
          lastName: event.lastName,
          email: event.email,
        );
        final currentState = state;
        if (currentState is UserLoadedState) {
          final List<UserModel> updatedUserList =
              List.from(currentState.userList)..add(newUser);
          updatedUserList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          emit(UserLoadedState(userList: updatedUserList));
        }
      } catch (_) {
        emit(UserFailureState());
      }
    });
    on<UserDeleteEvent>((event, emit) async {
      try {
        await _sbService.deleteUser(event.id);
        _userService.emailList.removeWhere((e) => e.email == event.email);
      } catch (_) {
        emit(UserFailureState());
      }
    });
  }
}
