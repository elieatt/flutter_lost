import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/data/models/item.dart';
import 'dart:io' show Platform;

import 'package:lostsapp/data/models/message.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/delete_message_cubit.dart';
import 'package:lostsapp/logic/cubit/messages_cubit.dart';

import 'package:lostsapp/presentation/widgets/dialogs/awesome_dia.dart';
import 'package:lostsapp/presentation/widgets/global/item_image.dart';
import 'package:lostsapp/presentation/widgets/single_message_page_widgets/contact_buttons.dart';
import 'package:lostsapp/presentation/widgets/single_message_page_widgets/message_text.dart';
import 'package:lostsapp/presentation/widgets/single_message_page_widgets/sender_reciver_table.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/single_message_page_widgets/delete_button.dart';

class SingleMessagePage extends StatefulWidget {
  final Message message;

  const SingleMessagePage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  State<SingleMessagePage> createState() => _SingleMessagePageState();
}

class _SingleMessagePageState extends State<SingleMessagePage> {
  @override
  void initState() {
    String userId = context.read<AuthCubit>().getUser().id;
    if (widget.message.read == false &&
        widget.message.reciver["_id"] == userId) {
      context.read<MessagesCubit>().readMessage(
          context.read<AuthCubit>().getUser().token, userId, widget.message.id);
    }
    super.initState();
  }

  Future<void> _contactViaWhatsapp(String phoneNumber) async {
    String url;
    if (Platform.isAndroid) {
      url = "whatsapp://send?phone=$phoneNumber"; // new line
    } else {
      url = "https://api.whatsapp.com/send?phone=$phoneNumber=hi"; // new line
    }
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch ';
    }
  }

  Future<void> _contactViaPhoneCall(String phoneNumber) async {
    await launchUrl(Uri.parse(
        'tel:${phoneNumber.substring(0, 4)}${phoneNumber.substring(4)}'));
  }

  Future<void> _contactViaEmail(String email) async {
    await launchUrl(Uri.parse(
        'mailto:$email?subject=Im sending to you from lost apps &body=Here goes your message'));
  }

  Widget _buildDivider() {
    return const Divider(
      color: Colors.black,
      height: 40,
      indent: 40,
      endIndent: 40,
    );
  }

  Widget _buildHelpText() {
    return Container(
      padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
      child: Text(
        "You can contact with sender via any one of those methods",
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 17,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget pageContent(double pageWidth, BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Message Info"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.scaleDown,
              child: SenderReciverTable(
                pageWidth: pageWidth,
                sender: widget.message.sender["userName"],
                reciver: widget.message.reciver["userName"],
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.only(right: 7, left: 7, bottom: 7),
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Theme.of(context).colorScheme.primary),
                  borderRadius: BorderRadius.circular(25)),
              child: TextButton(
                onPressed: (() => Navigator.pushNamed(context, "/itemView",
                    arguments: Item.fromDynamic(widget.message.item))),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      child: Text(
                        "ITEM : " + widget.message.item["title"],
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    ItemImage(
                        imageWidth:
                            pageWidth < 750 ? pageWidth / 1.5 : pageWidth / 2.5,
                        heroTag: widget.message.id,
                        imageUrl: widget.message.item["imageUrl"]),
                  ],
                ),
              ),
            ),
            _buildDivider(),
            Container(
              padding: const EdgeInsets.only(bottom: 25, left: 25, right: 25),
              child: Text(
                "MESSAGE",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            MessageText(
                pageWidth: pageWidth, messagetxt: widget.message.messageText),
            _buildDivider(),
            BlocProvider.of<AuthCubit>(context).getUser().id ==
                    widget.message.sender["_id"]
                ? Container()
                : Column(
                    children: [
                      _buildHelpText(),
                      ContactButtons(
                          email: widget.message.sender["email"],
                          phoneNumber: widget.message.sender["phoneNumber"],
                          contactViaWhatsapp: _contactViaWhatsapp,
                          contactViaEmail: _contactViaEmail,
                          contactViaPhoneCall: _contactViaPhoneCall),
                    ],
                  ),
            _buildDivider(),
            BlocBuilder<DeleteMessageCubit, DeleteMessageState>(
              builder: (context, state) {
                if (state is DeleteMessageProgress) {
                  return Container(
                    padding: const EdgeInsets.all(15),
                    child: Center(
                      child: CircularProgressIndicator(
                          color: Colors.red.withOpacity(1)),
                    ),
                  );
                }
                return DeleteButton(messageId: widget.message.id);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double pageWidth = MediaQuery.of(context).size.width;
    return BlocListener<DeleteMessageCubit, DeleteMessageState>(
        listener: (context, state) {
          if (state is DeleteMessageFailed) {
            buildAwrsomeDia(context, "Delete Failed", state.errorMessage, "OK",
                    type: DialogType.ERROR)
                .show();
          } else if (state is DeleteMessageSucceed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.successMessage)));
            Navigator.of(context).pop(true);
          }
        },
        child: pageContent(pageWidth, context));
  }
}
