import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/messages_cubit.dart';

BottomNavigationBar buildBottomNavigator(
    BuildContext context, int _selectedindex, void Function(int) onTapped) {
  return BottomNavigationBar(
    onTap: onTapped,
    //iconSize: 20,
    type: BottomNavigationBarType.fixed,

    currentIndex: _selectedindex,
    // onTap: onTapped,
    items: [
      const BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: ('Home'),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.add_box),
        label: 'Post',
      ),
      BottomNavigationBarItem(
        icon: BlocBuilder<MessagesCubit, MessagesState>(
            buildWhen: (previous, current) {
          return current is! MessagesProgress &&
              current is! MessagesSentMessagesFound &&
              current is! MessagesNoSentMessagesFound;
        }, builder: ((context, state) {
          if (state is MessagesrecivedMessagesFound) {
            if (state.unReadMessagesCount > 0) {
              return Badge(
                badgeColor: Theme.of(context).colorScheme.background,
                badgeContent: Text(state.unReadMessagesCount.toString()),
                child: const Icon(Icons.mail),
              );
            }
          }
          return const Icon(Icons.mail);
        })),
        label: ('Messages'),
      )
    ],
  );
}
