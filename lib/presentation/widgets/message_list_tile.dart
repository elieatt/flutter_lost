// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/data/models/message.dart';
import 'package:lostsapp/presentation/widgets/item_image.dart';

import '../../logic/cubit/auth_cubit.dart';
import '../../logic/cubit/messages_cubit.dart';

class MessageListTile extends StatelessWidget {
  final bool messageType; //true means recived and false means sent
  final Message message;

  const MessageListTile({
    Key? key,
    required this.messageType,
    required this.message,
  }) : super(key: key);

  Future<void> _pushSingleMessagePageAndWait(
      BuildContext context, Message message, bool type) async {
    final refresh = await Navigator.pushNamed(
      context,
      "/messageView",
      arguments: message,
    );
    if (refresh != true) {
      return;
    }
    final userId = BlocProvider.of<AuthCubit>(context).user!.id;
    final token = BlocProvider.of<AuthCubit>(context).user!.token;
    if (refresh == true && type) {
      BlocProvider.of<MessagesCubit>(context)
          .getRecivedMessages(token, userId, true);
    } else if (refresh == true && !type) {
      BlocProvider.of<MessagesCubit>(context).getSentMessages(token, userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: ItemImage(
            heroTag: message.id,
            imageUrl: message.item["imageUrl"],
            imageHeight: 40),
      ),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(
          message.messageText.length > 37
              ? message.messageText.substring(0, 37) + "......"
              : message.messageText,
        ),
        messageType == true && message.read == false
            ? Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
              )
            : Container(),
      ]),
      subtitle: Text("item: " + message.item["title"]),
      trailing: IconButton(
          onPressed: () {
            _pushSingleMessagePageAndWait(context, message, messageType);
          },
          icon: const Icon(Icons.info)),
    );
  }
}
