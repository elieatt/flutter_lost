import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/constants/enums.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/edit_user_info_cubit.dart';
import 'package:lostsapp/presentation/widgets/dialogs/awesome_dia.dart';

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

  void updateInfo() {
    setState(() {
      _user = context.read<AuthCubit>().getUser();
      _userName = _user.userName;
      _email = _user.email;
      _phoneNumber = _user.phoneNumber;
    });
  }

  void _showProccessingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: Dialog(
              child: SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width / 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text("proccessing"),
                      SizedBox(
                        width: 50,
                      ),
                      CircularProgressIndicator()
                    ],
                  )),
            ),
          );
        });
  }

  Widget _buildPageContent(BuildContext context) {
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
        UserCredentialCardView(
          title: "My user name",
          credientalValue: _userName,
          icon: Icons.person,
          editable: true,
          editType: EditAccountType.userName,
        ),
        UserCredentialCardView(
          icon: Icons.email,
          title: 'My email address',
          credientalValue: _email,
          editable: false,
        ),
        UserCredentialCardView(
          title: 'My phone number',
          icon: Icons.phone,
          credientalValue: _phoneNumber,
          editable: true,
          editType: EditAccountType.phoneNumber,
        ),
        const UserCredentialCardView(
          title: "My password",
          credientalValue: "********",
          icon: Icons.password,
          editable: true,
          editType: EditAccountType.password,
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditUserInfoCubit, EditUserInfoState>(
      listener: (context, state) async {
        if (state is EditUserInfoProgress) {
          _showProccessingDialog();
        } else if (state is EditUserInfoFailed) {
          Navigator.of(context).pop();
          buildAwrsomeDia(context, "Failed", state.failMessage, "OK",
                  type: DialogType.ERROR)
              .show();
        } else if (state is EditUserInfoSuccessed) {
          print("state info " + state.info.toString());
          Navigator.of(context).pop();

          await context.read<AuthCubit>().editUserInfo(state.info);
          buildAwrsomeDia(
                  context, "Changed successfully", state.successMessage, "OK",
                  type: DialogType.SUCCES)
              .show();
          updateInfo();
        }
      },
      child: _buildPageContent(context),
    );
  }
}
