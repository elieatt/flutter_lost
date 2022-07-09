import 'package:flutter/material.dart';

AppBar buildAppBar(int index, TabController? tc) {
  if (tc != null && index == 0) {
    return AppBar(
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
      ],
      bottom: TabBar(
        controller: tc,
        labelColor: Colors.white,
        tabs: const [
          Tab(
            text: 'Missing',
            icon: Icon(Icons.search_off),
          ),
          Tab(
            text: 'Found things',
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
  }
  return AppBar(
    title: Text("Add Item"),
  );
}
