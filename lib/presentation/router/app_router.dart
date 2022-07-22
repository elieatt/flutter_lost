import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/data/models/item.dart';
import 'package:lostsapp/data/models/message.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/delete_message_cubit.dart';
import 'package:lostsapp/logic/cubit/messages_cubit.dart';
import 'package:lostsapp/logic/cubit/send_message_cubit.dart';
import 'package:lostsapp/presentation/pages/auth_page.dart';
import 'package:lostsapp/presentation/pages/single_item_page.dart';
import 'package:lostsapp/presentation/pages/single_message_page.dart';
import 'package:lostsapp/presentation/pages/user_items_page.dart';

import '../../logic/cubit/delete_item_cubit.dart';
import '../pages/home.dart';

class AppRouter {
  Route? onGeneratedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          /*return AuthPage();*/
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return const HomePage();
            } else {
              return AuthPage();
            }
          }));
        });
      case '/itemView':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return BlocProvider<SendMessageCubit>(
                create: (context) => SendMessageCubit(),
                child: SingleItemPage(item: routeSettings.arguments as Item),
              );
            } else {
              return AuthPage();
            }
          }));
        });

      case '/messageView':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return BlocProvider<DeleteMessageCubit>(
                create: (context) => DeleteMessageCubit(),
                child: SingleMessagePage(
                    message: routeSettings.arguments as Message),
              );
            } else {
              return AuthPage();
            }
          }));
        });

      case '/myItems':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return BlocProvider<DeleteItemCubit>(
                create: (context) => DeleteItemCubit(),
                child: UserItemsPage(),
              );
            } else {
              return AuthPage();
            }
          }));
        });
    }

    return null;
  }
}
