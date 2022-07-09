import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/widgets/item_card.dart';

import '../../logic/cubit/items_cubit.dart';

class FoundItemsPage extends StatelessWidget {
  FoundItemsPage({Key? key}) : super(key: key);
  late AuthState _authState;
  late AuthLoginedIn _authLoginedInState;

  @override
  Widget build(BuildContext context) {
    double pageHeight = MediaQuery.of(context).size.height;
    _authState = context.watch<AuthCubit>().state;
    if (_authState is AuthLoginedIn) {
      _authLoginedInState = _authState as AuthLoginedIn;
      BlocProvider.of<ItemsCubit>(context)
          .fetchFoundItems(_authLoginedInState.user.token, false);
    }
    /*  BlocProvider.of<ItemsCubit>(context)
        .fetchFoundItems(BlocProvider.of<AuthCubit>(context).user!.token); */

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ItemsCubit>(context)
            .fetchFoundItems(_authLoginedInState.user.token, true);
      },
      child: BlocBuilder<ItemsCubit, ItemsState>(builder: (context, state) {
        if (state is ItemsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemsNoInternet) {
          return Center(
              child: ListView(children: [
            SizedBox(
              height: pageHeight / 3.5,
            ),
            Center(
              child: Icon(
                Icons.wifi_off_rounded,
                size: 50,
                color: Theme.of(context).accentColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const Center(
              child: Text(
                "Check your internet connection and try again",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ]));
        } else if (state is FoundItemsFound) {
          return ListView.builder(
              itemCount: state.foundItems.length,
              itemBuilder: (BuildContext context, int i) {
                return ItemCard(state.foundItems[i]);
              });
        } else if (state is ItemsNoItemsFound) {
          return Center(
            child: ListView(children: [
              SizedBox(height: pageHeight / 2),
              const Center(child: Text("NO ITEMS FOUND"))
            ]),
          );
        }
        return ListView(children: [
          SizedBox(
            height: pageHeight / 2,
          ),
          const Center(child: Text("error"))
        ]);
      }),
    );
  }
}
