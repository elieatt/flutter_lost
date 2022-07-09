import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lostsapp/presentation/widgets/drawer.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: const Text("Messages"),
          bottom: const TabBar(tabs: [
            Tab(text: "Recived", icon: FaIcon(FontAwesomeIcons.mailchimp)),
            Tab(
              text: "Sent",
              icon: Icon(Icons.mail),
            )
          ]),
        ),
        body:
            const TabBarView(children: [Icon(Icons.abc), Icon(Icons.ac_unit)]),
      ),
    );
  }
}
