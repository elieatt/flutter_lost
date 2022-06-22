import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/widgets/item_card.dart';

import '../../logic/cubit/items_cubit.dart';

class FoundItemsPage extends StatelessWidget {
  const FoundItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemsCubit>(context)
        .fetchFoundItems(BlocProvider.of<AuthCubit>(context).user!.token);

    return BlocBuilder<ItemsCubit, ItemsState>(builder: (context, state) {
      if (state is ItemsInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ItemsNoInternet) {
        return Center(
            child: Column(children: const [
          Icon(Icons.signal_wifi_off),
          Text("Check your internet connection and try again")
        ]));
      } else if (state is FoundItemsFound) {
        return ListView.builder(
            itemCount: state.foundItems.length,
            itemBuilder: (BuildContext context, int i) {
              return ItemCard(state.foundItems[i]);
            });
      } else if (state is ItemsNoItemsFound) {
        return const Center(
          child: Text("NO ITEMS FOUND"),
        );
      }
      return const Text("error");
    });
  }
}
