import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/pages/auth_page.dart';

import '../pages/home.dart';

class AppRouter {
  Route? onGeneratedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return HomePage();
            } else {
              return AuthPage();
            }
          }));
        });
      case '/home':
        return MaterialPageRoute(builder: (context) {
          return BlocBuilder<AuthCubit, AuthState>(builder: ((context, state) {
            if (state is AuthLoginedIn) {
              return HomePage();
            } else {
              return AuthPage();
            }
          }));
        });
    }
  }
}
