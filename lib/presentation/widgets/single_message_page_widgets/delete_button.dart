import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/delete_message_cubit.dart';

import '../dialogs/delete_confirm_dialog.dart';

class DeleteButton extends StatelessWidget {
  final String messageId;

  const DeleteButton({Key? key, required this.messageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: pageWidth < 750
          ? const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 25)
          : EdgeInsets.symmetric(horizontal: pageWidth / 4, vertical: 15),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.red.withOpacity(0.95)),
        ),
        onPressed: () async {
          bool? toDelete =
              await showDeleteConfirmDialog(context, "messages", null);
          if (toDelete != null && toDelete) {
            await context.read<DeleteMessageCubit>().deleteMessage(
                context.read<AuthCubit>().getUser().token, messageId);
          }
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text("Delete Message"),
            SizedBox(
              width: 10,
            ),
            FaIcon(
              FontAwesomeIcons.trash,
              size: 17,
            )
          ],
        ),
      ),
    );
  }
}
