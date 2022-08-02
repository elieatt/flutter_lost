import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/delete_item_cubit.dart';
import 'package:lostsapp/presentation/widgets/dialogs/delete_confirm_dialog.dart';

import '../../../data/models/item.dart';
import '../dialogs/delete_confirm_dialog.dart';
import '../global/item_image.dart';

class ItemListTile extends StatelessWidget {
  final Item item;

  const ItemListTile({Key? key, required this.item}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            child: ItemImage(
              boxFit: BoxFit.cover,
              heroTag: item.id,
              imageHeight: 40.0,
              imageWidth: 40.0,
              imageUrl: item.imageUrl,
            ),
          ),
          title: Text(item.title),
          onTap: () {
            Navigator.of(context).pushNamed("/itemView", arguments: item);
          },
          trailing: IconButton(
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.red,
            ),
            onPressed: () async {
              bool? descision = await showDeleteConfirmDialog(context, "items");
              if (descision != null && descision == true) {
                final String token = context.read<AuthCubit>().user!.token;
                await context
                    .read<DeleteItemCubit>()
                    .deleteAnItem(token, item.id);
              }
            },
          ),
        ),
        const Divider()
      ],
    );
  }
}
