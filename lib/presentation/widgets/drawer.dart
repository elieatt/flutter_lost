import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';

_showDialogAlert(context) {
  AwesomeDialog(
    context: context,
    animType: AnimType.SCALE,
    dialogType: DialogType.WARNING,
    body: const Center(
      child: Text(
        'You Will Log Out!',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
    ),
    title: 'This is Ignored',
    desc: 'This is also Ignored',
    btnCancelOnPress: () {},
    btnCancelText: 'Cancel',
    btnOkText: " Countinue",
    btnOkOnPress: () {
      BlocProvider.of<AuthCubit>(context).logOut();
      Flushbar(
        flushbarPosition: FlushbarPosition.TOP,
        duration: const Duration(seconds: 3),
        icon: const Icon(
          Icons.done,
          size: 40,
          color: Colors.green,
        ),
        backgroundColor: Colors.white,
        messageText: const Text(
          'Successful LogIn',
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ).show(context);
    },
  ).show();
}

Widget buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(children: [
      AppBar(
        leading: const Icon(
          Icons.settings,
          color: Colors.black,
        ),
        automaticallyImplyLeading: false,
        title: Text('Options'),
      ),
      ListTile(
        leading: const Icon(Icons.account_circle),
        title: const Text('My Profile'),
        onTap: () {
          Navigator.pushNamed(context, '/profile');
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.add),
        title: const Text('Post What you Lost or Found'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/add');
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.question_answer),
        title: const Text('Confirm requests'),
        onTap: () {
          Navigator.pushNamed(context, '/myConfirms');
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () {
          Navigator.pushReplacementNamed(context, '/home');
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.logout),
        title: const Text('LogOut'),
        onTap: () => _showDialogAlert(context),
      ),
      const Divider(),
    ]),
  );
}
