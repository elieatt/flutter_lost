import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lostsapp/presentation/pages/found_items.dart';
import '../../logic/cubit/items_cubit.dart';
import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  int _selectedindex = 1;
  /* void _navigator(int index) {
    setState(() {
      _selectedindex = index;
    });
  } */

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ItemsCubit>(context).fetchItems();
    return Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(
          actions: [],
          title: const Center(
            child: Text(
              "Homd Page",
            ),
          ),
        ),
        body: FoundItems(),
        floatingActionButton: FAQ(),
        bottomNavigationBar: buildBottomNavigator(context, _selectedindex));
  }

  Widget FAQ() {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      backgroundColor: Colors.amber,
      overlayColor: Colors.black,
      overlayOpacity: 0.4,
      children: [
        SpeedDialChild(
          label: "Favorite",
          child: IconButton(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              //show favorited
            },
          ),
        ),
        SpeedDialChild(
          label: "Lost",
          child: IconButton(
            icon: Icon(
              Icons.search_off,
              color: Colors.black,
            ),
            onPressed: () {
              //show only losts
            },
          ),
        ),
        SpeedDialChild(
          label: "Fond",
          child: IconButton(
            icon: Icon(
              Icons.search_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              //show only founds
            },
          ),
        ),
        SpeedDialChild(
          label: "Home Page",
          child: IconButton(
            icon: Icon(
              Icons.home_rounded,
            ),
            onPressed: () {
              //show both found and losts
            },
          ),
        )
      ],
    );
  }
}
