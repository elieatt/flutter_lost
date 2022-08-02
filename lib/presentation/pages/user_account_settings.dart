import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/widgets/auth_page_widgets/user_name_form_field.dart';
import '../pages/auth_page.dart';

class UserAcoountSettings extends StatefulWidget {
  @override
  State<UserAcoountSettings> createState() => _UserAcoountSettingsState();
}

class _UserAcoountSettingsState extends State<UserAcoountSettings> {
  String _userName = '';
  void _setName(String name) {
    _userName = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Account")),
      body: ListView(children: [
        ListTile(
          leading: const Text("email :"),
          title: Text(context.read<AuthCubit>().user!.email),
        ),
        ListTile(
            leading: Text("Name :"),
            title: UserNameFormField(
              setUserName: _setName,
              ininValue: context.read<AuthCubit>().user!.userName,
              readOnly: true,
            ))
      ]),
    );
  }
}
