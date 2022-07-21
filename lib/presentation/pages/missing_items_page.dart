import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        } else if (state is LostItemsFound) {
          return ListView.builder(
              itemCount: state.lostItems.length,
              itemBuilder: (BuildContext _, int i) {
                return ItemCard(state.lostItems[i]);
              });
        } else if (state is ItemsNoItemsFound) {
          return Center(
            child: ListView(children: [
              SizedBox(height: pageHeight / 3),
              const Center(
                child: FaIcon(
                  FontAwesomeIcons.ban,
                  size: 80,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
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
