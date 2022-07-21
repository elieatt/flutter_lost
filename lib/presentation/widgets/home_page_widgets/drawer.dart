import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';

_showDialogAlert(context) {
  AwesomeDialog(
      btnOkColor: Theme.of(context).accentColor,
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
      }).show();
}

Widget buildDrawer(BuildContext context, void Function(int) onTapped) {
  return Drawer(
    child: Column(children: [
      AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Row(children: [
          const Icon(
            Icons.person,
            size: 50,
          ),
          const SizedBox(
            width: 20,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              context.read<AuthCubit>().user!.userName,
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            Text("0" + context.read<AuthCubit>().user!.phoneNumber.substring(4),
                textAlign: TextAlign.left)
          ])
        ]),
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Home'),
        onTap: () {
          Navigator.pop(context);
          onTapped(0);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.add),
        title: const Text('Post an item'),
        onTap: () {
          Navigator.pop(context);
          onTapped(1);
        },
      ),
      const Divider(),
      ListTile(
        leading: const Icon(Icons.question_answer),
        title: const Text('Messages'),
        onTap: () {
          Navigator.pop(context);
          onTapped(2);
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
