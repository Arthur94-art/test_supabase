import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_supabase/bloc/email/email_bloc.dart';

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
    return GestureDetector(
      onTap: _onCheckBoxTap,
      child: Card(
        color: Colors.blueGrey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget._name, style: TextStyle(color: Colors.grey[300])),
                  const SizedBox(height: 5),
                  Text(widget._lastName,
                      style: TextStyle(color: Colors.grey[300])),
                  const SizedBox(height: 5),
                  Text(widget._email,
                      style: TextStyle(color: Colors.grey[300])),
                  const SizedBox(height: 5),
                ],
              ),
              IconButton(
                color: Colors.grey[300],
                icon: Icon(
                  !_isTapped ? Icons.check_box_outline_blank : Icons.check_box,
                ),
                onPressed: _onCheckBoxTap,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCheckBoxTap() {
    context.read<EmailBloc>().add(AddEmailToListEvent(
          email: widget._email,
          name: widget._name,
          lastName: widget._lastName,
        ));
    _isTapped = !_isTapped;
    setState(() {});
  }
}
