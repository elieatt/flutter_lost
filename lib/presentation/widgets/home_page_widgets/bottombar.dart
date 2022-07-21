import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/messages_cubit.dart';

BottomNavigationBar buildBottomNavigator(
    BuildContext context, int _selectedindex, void Function(int) onTapped) {
  return BottomNavigationBar(
    iconSize: 20,
    type: BottomNavigationBarType.fixed,
    currentIndex: _selectedindex,
    // onTap: onTapped,
    items: [
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            onTapped(0);
          },
        ),
        label: ('Home'),
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.add_box),
          onPressed: () {
            onTapped(1);
          },
        ),
        label: 'Add',
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
                badgeColor: Colors.green,
                badgeContent: Text(state.unReadMessagesCount.toString()),
                child: IconButton(
                  icon: const Icon(Icons.mail),
                  onPressed: () {
                    onTapped(2);
                  },
                ),
              );
            }
          }
          return IconButton(
            icon: const Icon(Icons.mail),
            onPressed: () {
              onTapped(2);
            },
          );
        })),
        label: ('Messages'),
      )
    ],
  );
}
