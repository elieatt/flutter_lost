// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:lostsapp/constants/themes.dart';
import 'package:flutter/foundation.dart';

import 'package:lostsapp/data/repositories/auth_repository.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/internet_cubit.dart';
import 'package:lostsapp/logic/cubit/messages_cubit.dart';
import 'package:lostsapp/logic/cubit/themes_cubit.dart';
import 'package:lostsapp/presentation/router/app_router.dart';
import 'package:path_provider/path_provider.dart';

import 'data/network_services/items_netwroks_service.dart';
import 'data/repositories/items_repository.dart';
import 'logic/cubit/items_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppRouter appRouter = AppRouter();

  final storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());
  print(storage);
  HydratedBlocOverrides.runZoned(
    () => runApp(MyApp(
      appRouter: appRouter,
    )),
    storage: storage,
  );
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({
    Key? key,
    required this.appRouter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(AuthRepository()),
          lazy: false,
        ),
        BlocProvider<ItemsCubit>(
            create: (context) => ItemsCubit(
                  InternetCubit(connectivity: Connectivity()),
                  ItemsRepository(ItemsNetworkService()),
                )),
        BlocProvider(create: (context) => MessagesCubit()),
        BlocProvider(create: ((context) => ThemesCubit()))
      ],
      child: BlocBuilder<ThemesCubit, ThemesState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'LostsApp',
            theme: themeArray[state.themeIndex],
            onGenerateRoute: appRouter.onGeneratedRoutes,
          );
        },
      ),
    );
  }
}
