import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/items_cubit.dart';
import '../widgets/item_card.dart';

class MissingPage extends StatefulWidget {
  const MissingPage({Key? key}) : super(key: key);

  @override
  State<MissingPage> createState() => _MissingPageState();
}

class _MissingPageState extends State<MissingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemsCubit>(context)
        .fetchLostItems(BlocProvider.of<AuthCubit>(context).user!.token);
    print('built');

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
      } else if (state is LostItemsFound) {
        return ListView.builder(
            itemCount: state.lostItems.length,
            itemBuilder: (BuildContext context, int i) {
              return ItemCard(state.lostItems[i]);
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
