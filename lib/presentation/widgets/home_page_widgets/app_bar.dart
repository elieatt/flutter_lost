import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar buildAppBar(
    int index, TabController? htc, TabController? mtc, BuildContext context) {
  if (htc != null && index == 0) {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
      ],
      bottom: TabBar(
        indicatorColor: Theme.of(context).colorScheme.primary,

        //indicatorPadding: EdgeInsets.all(-40),
        controller: htc,
        tabs: const [
          Tab(
            height: 50,
            text: 'Missing ',
            icon: Icon(Icons.search_off),
          ),
          Tab(
            height: 55,
            text: 'Found ',
            icon: Icon(Icons.search_outlined),
          )
        ],
      ),
      title: const Center(
        child: Text(
          "Home",
        ),
      ),
    );
  } else if (index == 1) {
    return AppBar(
      title: const Text("Post an Item"),
    );
  }
  return AppBar(
    title: const Center(
        child: Padding(
      padding: EdgeInsets.only(right: 50),
      child: Text("Messages"),
    )),
    bottom: TabBar(
        indicatorColor: Theme.of(context).colorScheme.primary,
        controller: mtc,
        tabs: const [
          Tab(
              height: 50,
              text: "Recived",
              icon: FaIcon(FontAwesomeIcons.inbox)),
          Tab(
            height: 50,
            text: "Sent",
            icon: Icon(Icons.chat_outlined),
          )
        ]),
  );
}
