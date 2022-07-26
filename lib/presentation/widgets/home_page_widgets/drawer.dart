// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/items_cubit.dart';
import 'package:lostsapp/logic/cubit/messages_cubit.dart';

class HomePageDrawer extends StatelessWidget {
  final void Function(int) onTapped;
  final TabController htb;
  final TabController mtb;
  final BuildContext parentContext;
  const HomePageDrawer({
    Key? key,
    required this.onTapped,
    required this.htb,
    required this.mtb,
    required this.parentContext,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(children: [
        AppBar(
          toolbarHeight: 100,
          automaticallyImplyLeading: false,
          title: const UserNameAndPhoneNUmberBadge(),
        ),
        SingleChildScrollView(
          child: Column(children: [
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
              leading: const Icon(Icons.contact_page),
              title: const Text('My items'),
              onTap: () async {
                final token = context.read<AuthCubit>().getUser().token;
                final userId = context.read<AuthCubit>().getUser().id;
                Navigator.of(context).pop();
                await Navigator.of(context).pushNamed("/myItems");
                //refreshing items and messages
                if (htb.index == 0) {
                  parentContext.read<ItemsCubit>().fetchLostItems(token, true);
                } else {
                  parentContext.read<ItemsCubit>().fetchFoundItems(token, true);
                }
                parentContext
                    .read<MessagesCubit>()
                    .getRecivedMessages(token, userId, true);
                if (mtb.index == 1) {
                  parentContext.read<MessagesCubit>().getSentMessages(
                        token,
                        userId,
                      );
                }
              },
            ),
            const Divider(),
            ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushNamed("/settingsPage");
                }),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () => _showDialogAlert(context),
            ),
            const Divider(),
          ]),
        )
      ]),
    );
  }
}

class UserNameAndPhoneNUmberBadge extends StatelessWidget {
  const UserNameAndPhoneNUmberBadge({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Icon(
        Icons.person,
        size: 50,
      ),
      const SizedBox(
        width: 20,
      ),
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          context.read<AuthCubit>().getUser().userName,
          textAlign: TextAlign.left,
        ),
        const SizedBox(
          height: 10,
        ),
        Text("0" + context.read<AuthCubit>().getUser().phoneNumber.substring(4),
            textAlign: TextAlign.left)
      ])
    ]);
  }
}

_showDialogAlert(context) {
  AwesomeDialog(
      btnOkColor: Theme.of(context).colorScheme.secondary,
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
