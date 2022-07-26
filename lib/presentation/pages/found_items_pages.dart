import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/widgets/home_page_widgets/item_card.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_internet_sign.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_items_found_sign.dart';

import '../../logic/cubit/items_cubit.dart';

class FoundItemsPage extends StatefulWidget {
  const FoundItemsPage({Key? key}) : super(key: key);

  @override
  State<FoundItemsPage> createState() => _FoundItemsPageState();
}

class _FoundItemsPageState extends State<FoundItemsPage> {
  @override
  void initState() {
    final String token = context.read<AuthCubit>().getUser().token;
    if (context.read<ItemsCubit>().getPostStatus()) {
      context.read<ItemsCubit>().fetchFoundItems(token, true);
    } else if (context.read<ItemsCubit>().getNotFilterdStatus()) {
      context.read<ItemsCubit>().fetchFoundItems(token, false);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double pageHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ItemsCubit>(context)
            .fetchFoundItems(context.read<AuthCubit>().getUser().token, true);
      },
      child:
          BlocBuilder<ItemsCubit, ItemsState>(buildWhen: (previous, current) {
        return current is! LostItemsFound;
      }, builder: (context, state) {
        if (state is ItemsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemsNoInternet) {
          return Center(
              child: NoInternetSign(
            pageHeight: pageHeight,
          ));
        } else if (state is FoundItemsFound) {
          return ListView.builder(
              itemCount: state.foundItems.length,
              itemBuilder: (BuildContext context, int i) {
                return ItemCard(state.foundItems[i]);
              });
        } else if (state is ItemsFilteredItems) {
          return ListView.builder(
            itemBuilder: (_, i) {
              return ItemCard(state.filteredItems[i]);
            },
            itemCount: state.filteredItems.length,
          );
        } else if (state is ItemsNoItemsFound) {
          return Center(
              child: NoItemsFoundSign(
            pageHeight: pageHeight,
          ));
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
