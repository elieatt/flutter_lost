import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/delete_message_cubit.dart';

class DeleteButton extends StatelessWidget {
  final String messageId;

  const DeleteButton({Key? key, required this.messageId}) : super(key: key);
  Future<bool> _showConfirmDialog<bool>(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Are you sure?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            content: Text(
              "Deleted Items can't be resotred",
              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
            ),
            actions: [
              TextButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: const Text(
                  "Delete",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 25),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        ),
        onPressed: () async {
          bool toDelete = await _showConfirmDialog(context);
          if (toDelete) {
            await context.read<DeleteMessageCubit>().deleteMessage(
                context.read<AuthCubit>().user!.token, messageId);
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
