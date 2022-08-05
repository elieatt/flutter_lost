import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/constants/FormFieldMapping.dart';
import 'package:lostsapp/constants/enums.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';

import 'package:lostsapp/presentation/widgets/user_account_settings_widgets/user_credential_view.dart';
import '../../data/models/user.dart';

class UserAcoountSettings extends StatefulWidget {
  const UserAcoountSettings({Key? key}) : super(key: key);

  @override
  State<UserAcoountSettings> createState() => _UserAcoountSettingsState();
}

class _UserAcoountSettingsState extends State<UserAcoountSettings> {
  late User _user;
  late String _email, _userName, _phoneNumber;

  @override
  void initState() {
    _user = context.read<AuthCubit>().getUser();
    _userName = _user.userName;
    _email = _user.email;
    _phoneNumber = _user.phoneNumber;

    super.initState();
  }

  void _setName(String name) {
    _userName = name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Account")),
      body: ListView(children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10),
          child: Text(
            "My account information : ",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary, fontSize: 25),
          ),
        ),
        UserCredentialView(
          title: "My user name",
          credientalValue: _userName,
          icon: Icons.person,
          editable: true,
        ),
        UserCredentialView(
          icon: Icons.email,
          title: 'My email address',
          credientalValue: _email,
          editable: false,
        ),
        UserCredentialView(
          title: 'My phone number',
          icon: Icons.phone,
          credientalValue: _phoneNumber,
          editable: true,
        ),
        const UserCredentialView(
          title: "My password",
          credientalValue: "********",
          icon: Icons.password,
          editable: true,
        )
      ]),
    );
  }
}
