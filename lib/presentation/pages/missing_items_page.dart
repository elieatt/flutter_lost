import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/items_cubit.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/error_sign.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_internet_sign.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_items_found_sign.dart';

import '../widgets/home_page_widgets/item_card.dart';

class MissingPage extends StatefulWidget {
  const MissingPage({Key? key}) : super(key: key);

  @override
  State<MissingPage> createState() => _MissingPageState();
}

class _MissingPageState extends State<MissingPage> {
  @override
  void initState() {
    context
        .read<ItemsCubit>()
        .fetchLostItems(context.read<AuthCubit>().user!.token, true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double pageHeight = MediaQuery.of(context).size.height;
    /*  BlocProvider.of<ItemsCubit>(context)
        .fetchLostItems(BlocProvider.of<AuthCubit>(context).user!.token, true); */
    print('built');

    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<ItemsCubit>(context).fetchLostItems(
            BlocProvider.of<AuthCubit>(context).user!.token, true);
      },
      child: BlocBuilder<ItemsCubit, ItemsState>(builder: (_, state) {
        if (state is ItemsInitial) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ItemsNoInternet) {
          return Center(child: NoInternetSign(pageHeight: pageHeight));
        } else if (state is LostItemsFound) {
          return ListView.builder(
              itemCount: state.lostItems.length,
              itemBuilder: (BuildContext _, int i) {
                return ItemCard(state.lostItems[i]);
              });
        } else if (state is ItemsNoItemsFound) {
          return Center(
            child: NoItemsFoundSign(pageHeight: pageHeight),
          );
        }
        return ErrorSign();
      }),
    );
  }
}
