import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/send_message_cubit.dart';
import 'package:lostsapp/presentation/widgets/awesome_dia.dart';
import 'package:lostsapp/presentation/widgets/card_widgets/date_tag.dart';
import 'package:lostsapp/presentation/widgets/card_widgets/location_and_category_tag.dart';
import 'package:lostsapp/presentation/widgets/card_widgets/userName_tag.dart';
import 'package:lostsapp/presentation/widgets/item_image.dart';
import 'package:lostsapp/presentation/widgets/single_message_page_widgets/delete_button.dart';

import '../../data/models/item.dart';

class SingleItemPage extends StatefulWidget {
  Item item;
  SingleItemPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  State<SingleItemPage> createState() => _SingleItemPageState();
}

class _SingleItemPageState extends State<SingleItemPage> {
  late TextEditingController messageController;
  @override
  void initState() {
    messageController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  Future<String?> openDialog(BuildContext context) async {
    return await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Enter your message"),
            content: TextField(
              controller: messageController,
              autofocus: true,
              maxLines: 5,
              minLines: 2,
            ),
            actions: <Widget>[
              Container(
                width: 40,
                alignment: Alignment.centerLeft,
                child: TextButton(
                    onPressed: (() =>
                        Navigator.of(context).pop(messageController.text)),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.send,
                          color: Colors.blue,
                        ),
                      ],
                    )),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.item.user["_id"]);
    double pageWidth = MediaQuery.of(context).size.width;

    return BlocListener<SendMessageCubit, SendMessageState>(
      listener: (context, state) {
        if (state is SendMessageFailed) {
          buildAwrsomeDia(context, "Failed", state.message, "OK",
                  type: DialogType.ERROR)
              .show();
        } else if (state is SendMessageSuccessed) {
          buildAwrsomeDia(
                  context,
                  "Sent Successfully",
                  "Reciver now can contact you via your number or your email ",
                  "OK",
                  type: DialogType.SUCCES)
              .show();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.item.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            /* crossAxisAlignment: CrossAxisAlignment.center, */
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: UserNameTag(name: widget.item.user["userName"]),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ItemImage(
                      heroTag: widget.item.id,
                      imageUrl: widget.item.imageUrl,
                      imageHeight: 400)),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: LocationTag(
                      widget.item.governorate, widget.item.category)),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: DateTag(widget.item.dateofloss)),
              UnconstrainedBox(
                child: Container(
                  width: pageWidth > 720 ? pageWidth / 3 : pageWidth - 100,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1,
                        color: Colors.amber,
                        style: BorderStyle.solid),
                  ),
                  child: Text(
                    widget.item.description,
                  ),
                ),
              ),
              BlocProvider.of<AuthCubit>(context).user!.id ==
                      widget.item.user["_id"]
                  ? Container()
                  : UnconstrainedBox(
                      child: Container(
                        width: pageWidth - 100,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 60),
                        child: BlocBuilder<SendMessageCubit, SendMessageState>(
                          builder: (context, state) {
                            if (state is SendMessageProgress) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else {
                              return ElevatedButton(
                                onPressed: () async {
                                  final messageText = await openDialog(context);
                                  if (messageText == null ||
                                      messageText.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Cant send empty message")));
                                  } else {
                                    await BlocProvider.of<SendMessageCubit>(
                                            context)
                                        .sendMessage(
                                            BlocProvider.of<AuthCubit>(context)
                                                .user!
                                                .token,
                                            widget.item.user["_id"],
                                            widget.item.id,
                                            messageController.text);
                                  }
                                  messageController.clear(); //messageText
                                },
                                child: (const Text("send a message")),
                              );
                            }
                          },
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
