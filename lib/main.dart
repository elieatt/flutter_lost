// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/data/repositories/auth_repository.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/internet_cubit.dart';
import 'package:lostsapp/presentation/router/app_router.dart';

import 'data/network_services/items_netwroks_service.dart';
import 'data/repositories/items_repository.dart';
import 'logic/cubit/items_cubit.dart';

void main() {
  final authRepo = AuthRepository();
  final itemsRepo = ItemsRepository(ItemsNetworkService());
  AppRouter appRouter = AppRouter();
  runApp(MyApp(
    appRouter: appRouter,
    itemsRepo: itemsRepo,
    authRepo: authRepo,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepo;
  final ItemsRepository itemsRepo;
  final AppRouter appRouter;
  MyApp({
    Key? key,
    required this.authRepo,
    required this.itemsRepo,
    required this.appRouter,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit(authRepo)),
        BlocProvider<ItemsCubit>(create: (context) => ItemsCubit(itemsRepo)),
        BlocProvider(
            create: (context) => InternetCubit(connectivity: Connectivity()))
      ],
      child: MaterialApp(
        theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.amber[100],
            accentColor: Colors.blueAccent),
        onGenerateRoute: appRouter.onGeneratedRoutes,
      ),
    );
  }
}
