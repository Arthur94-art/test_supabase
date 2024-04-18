import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_supabase/bloc/user_bloc.dart';

class CustomPopup extends StatefulWidget {
  const CustomPopup({
    super.key,
  });

  @override
  State<CustomPopup> createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoadedState) {
          Navigator.pop(context);
        }
      },
      child: AlertDialog(
        title: const Text('Введіть дані'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(hintText: 'First name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(hintText: 'Last name'),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(hintText: 'Email'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: _createUser,
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  void _createUser() {
    context.read<UserBloc>().add(
          UserAddEvent(
              name: _nameController.text,
              lastName: _lastNameController.text,
              email: _emailController.text),
        );
  }
}
