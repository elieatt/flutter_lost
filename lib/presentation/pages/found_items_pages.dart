import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/widgets/home_page_widgets/item_card.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_internet_sign.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_items_found_sign.dart';

import '../../logic/cubit/items_cubit.dart';

class FoundItemsPage extends StatefulWidget {
  FoundItemsPage({Key? key}) : super(key: key);

  @override
  State<FoundItemsPage> createState() => _FoundItemsPageState();
}

class _FoundItemsPageState extends State<FoundItemsPage> {
  @override
  void initState() {
    final String token = context.read<AuthCubit>().user!.token;
    context.read<ItemsCubit>().fetchFoundItems(token, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double pageHeight = MediaQuery.of(context).size.height;

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ItemsCubit>(context)
            .fetchFoundItems(context.read<AuthCubit>().user!.token, true);
      },
      child: BlocBuilder<ItemsCubit, ItemsState>(builder: (context, state) {
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
        } else if (state is ItemsNoItemsFound) {
          return Center(
              child: NoItemsFoundSign(
            pageHeight: pageHeight,
          ));
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
