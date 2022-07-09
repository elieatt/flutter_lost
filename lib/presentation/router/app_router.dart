import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/data/repositories/post_and_update_network_repository.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/post_item_cubit.dart';
import 'package:lostsapp/presentation/pages/add_page.dart';
import 'package:lostsapp/presentation/pages/auth_page.dart';
import 'package:lostsapp/presentation/router/custom_page_route.dart';

import '../pages/home.dart';

class AppRouter {
  final PostItemCubit PIC;

  AppRouter(this.PIC);
  Route? onGeneratedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          /*return AuthPage();*/
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return HomePage();
            } else {
              return AuthPage();
            }
          }));
        });
      case '/home':
        return MyCustomRoute(builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return HomePage();
            } else {
              return AuthPage();
            }
          }));
        });
    }
    return null;
  }
}
