// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/messages_cubit.dart';

import 'package:lostsapp/presentation/widgets/messages_page_widgets/message_list_tile.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_internet_sign.dart';

class MessagesPage extends StatelessWidget {
  final int index;
  const MessagesPage({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userId = BlocProvider.of<AuthCubit>(context).user!.id;
    final token = BlocProvider.of<AuthCubit>(context).user!.token;

    index == 0
        ? BlocProvider.of<MessagesCubit>(context)
            .getRecivedMessages(token, userId, true)
        : BlocProvider.of<MessagesCubit>(context)
            .getSentMessages(token, userId);
    return BlocBuilder<MessagesCubit, MessagesState>(
      buildWhen: (previous, current) {
        return (index == 0 &&
                current is! MessagesSentMessagesFound &&
                current is! MessagesNoSentMessagesFound) ||
            (index == 1 &&
                current is! MessagesrecivedMessagesFound &&
                current is! MessagesNoRecivedMessagesFound);
      },
      builder: (context, state) {
        if (state is MessagesProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MessagesNoInternet) {
          return NoInternetSign(
            pageHeight: MediaQuery.of(context).size.height,
          );
        } else if (state is MessagesNoRecivedMessagesFound ||
            state is MessagesNoSentMessagesFound) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.cancel_outlined,
                  color: Colors.red,
                  size: 40,
                ),
                const SizedBox(height: 10),
                Text(
                  index == 0 ? "Inbox is empty" : "You did,t send any message",
                  style: const TextStyle(fontWeight: FontWeight.normal),
                )
              ],
            ),
          );
        } else if (state is MessagesSentMessagesFound && index == 1) {
          return ListView.builder(
            itemCount: state.sentMessages.length,
            itemBuilder: (BuildContext context, int j) {
              return MessageListTile(
                message: state.sentMessages[j],
                messageType: false,
              );
            },
          );
        } else if (state is MessagesrecivedMessagesFound && index == 0) {
          return ListView.builder(
            itemCount: state.recivedMessages.length,
            itemBuilder: (BuildContext context, int i) {
              return MessageListTile(
                message: state.recivedMessages[i],
                messageType: true,
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
