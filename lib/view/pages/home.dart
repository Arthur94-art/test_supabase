import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_supabase/bloc/user_bloc.dart';
import 'package:test_supabase/data/models/user_model.dart';
import 'package:test_supabase/view/widgets/custom_popup.dart';
import 'package:test_supabase/view/widgets/user_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final UserBloc _userBloc;

  @override
  void initState() {
    super.initState();
    _userBloc = context.read<UserBloc>();
    _userBloc.add(UserFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) => _buildStateContent(state),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: IconButton(
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () => _showMyDialog(context),
          ),
        ),
      ],
    );
  }

  Widget _buildStateContent(UserState state) {
    if (state is UserInitialState) return _buildLoadingIndicator();
    if (state is UserLoadedState) return _buildUserList(state.userList);
    if (state is UserFailureState) return _buildErrorIndicator();
    return const SizedBox.shrink();
  }

  Widget _buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildUserList(List<UserModel> userList) {
    return userList.isEmpty
        ? const Center(child: Text('No added users'))
        : ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) =>
                _buildUserListItem(userList, index),
          );
  }

  Widget _buildUserListItem(List<UserModel> userList, int index) {
    final item = userList[index];
    return Dismissible(
      key: Key(item.id.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _userBloc.add(UserDeleteEvent(id: item.id));
        setState(() {
          userList.removeAt(index);
        });
      },
      background: _buildDismissibleBackground(),
      child: UserCard(
        name: item.firstName,
        lastName: item.lastName,
        email: item.email,
      ),
    );
  }

  Container _buildDismissibleBackground() {
    return Container(
      color: Colors.redAccent,
      alignment: Alignment.centerRight,
      child: const Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Icon(Icons.delete, color: Colors.white),
      ),
    );
  }

  Widget _buildErrorIndicator() {
    return const Text(
      'Something went wrong...',
      style: TextStyle(color: Colors.red),
    );
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const CustomPopup();
    },
  );
}
