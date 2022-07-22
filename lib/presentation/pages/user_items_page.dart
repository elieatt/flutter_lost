import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/delete_item_cubit.dart';
import 'package:lostsapp/logic/cubit/items_cubit.dart';
import 'package:lostsapp/presentation/widgets/awesome_dia.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_internet_sign.dart';
import 'package:lostsapp/presentation/widgets/items_loading_signs/no_items_found_sign.dart';
import 'package:lostsapp/presentation/widgets/user_item_page_widgets/item_list_tile.dart';

import '../widgets/items_loading_signs/error_sign.dart';

class UserItemsPage extends StatefulWidget {
  @override
  State<UserItemsPage> createState() => _UserItemsPageState();
}

class _UserItemsPageState extends State<UserItemsPage> {
  late String token;
  late String userId;
  @override
  void initState() {
    token = context.read<AuthCubit>().user!.token;
    userId = context.read<AuthCubit>().user!.id;
    context.read<ItemsCubit>().getUserItem(token, userId, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double pageHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(title: const Text("My Items")),
        body: BlocListener<DeleteItemCubit, DeleteItemState>(
          listener: (context, state) {
            if (state is DeleteItemProgress) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Container(
                        alignment: Alignment.center,
                        height: 40,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text("Deleting..."),
                              SizedBox(
                                width: 10,
                              ),
                              CircularProgressIndicator()
                            ]),
                      ),
                    );
                  });
            } else if (state is DeleteItemFailed) {
              Navigator.of(context).pop();
              buildAwrsomeDia(
                      context, "Delete Failed", state.failedMessage, "OK",
                      type: DialogType.ERROR)
                  .show();
            } else if (state is DeleteItemSuccess) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.successMessage)));
              context.read<ItemsCubit>().getUserItem(token, userId, true);
            }
          },
          child: BlocBuilder<ItemsCubit, ItemsState>(
            builder: (context, state) {
              if (state is ItemsInitial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ItemsNoInternet) {
                return Center(child: NoInternetSign(pageHeight: pageHeight));
              } else if (state is ItemsNoItemsFound) {
                return Center(
                  child: NoItemsFoundSign(pageHeight: pageHeight),
                );
              } else if (state is ItemsUserItemsFound) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ListView.builder(
                    itemCount: state.userItems.length,
                    itemBuilder: (context, index) {
                      return ItemListTile(item: state.userItems[index]);
                    },
                  ),
                );
              }
              return ErrorSign();
            },
          ),
        ));
  }
}
