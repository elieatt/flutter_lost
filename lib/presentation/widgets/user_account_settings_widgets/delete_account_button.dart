import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/cubit/auth_cubit.dart';
import '../../../logic/cubit/edit_user_info_cubit.dart';
import '../dialogs/delete_confirm_dialog.dart';

class DeleteAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.red[500])),
      onPressed: () async {
        bool result = await showDeleteConfirmDialog(context, "",
            "Deleting your account will  cause all of your data including your posted items , messages to be removed permanently!.");
        if (result) {
          context
              .read<EditUserInfoCubit>()
              .deleteUserAccount(context.read<AuthCubit>().getUser().token);
        }
      },
      child: const Text("Delete my account"),
    );
  }
}
