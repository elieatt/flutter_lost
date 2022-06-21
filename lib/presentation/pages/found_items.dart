import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/presentation/widgets/item_card.dart';

import '../../logic/cubit/items_cubit.dart';

class FoundItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItemsCubit, ItemsState>(builder: (context, state) {
      if (state is ItemsInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ItemsFound) {
        return ListView.builder(
            itemCount: state.items.length,
            itemBuilder: (BuildContext context, int i) {
              return ItemCard(state.items[i]);
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
