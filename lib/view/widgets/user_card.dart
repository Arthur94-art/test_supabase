import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_supabase/bloc/user_bloc.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required String name,
    required String lastName,
    required String email,
  })  : _name = name,
        _lastName = lastName,
        _email = email;

  final String _name;
  final String _lastName;
  final String _email;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget._name, style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 5),
                Text(widget._lastName,
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 5),
                Text(widget._email,
                    style: const TextStyle(color: Colors.white)),
                const SizedBox(height: 5),
              ],
            ),
            IconButton(
              color: Colors.white,
              icon: Icon(
                !_isTapped ? Icons.check_box_outline_blank : Icons.check_box,
              ),
              onPressed: _onCheckBoxTap,
            ),
          ],
        ),
      ),
    );
  }

  void _onCheckBoxTap() {
    context.read<UserBloc>().add(AddEmailToListEvent(
          email: widget._email,
          name: widget._name,
          lastName: widget._lastName,
        ));
    _isTapped = !_isTapped;
    setState(() {});
  }
}
