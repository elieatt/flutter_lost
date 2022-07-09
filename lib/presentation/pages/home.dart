import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/presentation/pages/found_items_pages.dart';
import 'package:lostsapp/presentation/pages/missing_items_page.dart';
import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int _selectedindex = 0;
  void onTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
  }

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is! AuthLoginedIn) {
          Navigator.of(context).pushReplacementNamed('/');
        }
      },
      child: Scaffold(
          drawer: buildDrawer(context),
          appBar: AppBar(
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list))
            ],
            bottom: TabBar(
              controller: _tabController,
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
          ),
          body: TabBarView(
              controller: _tabController,
              children: [MissingPage(), FoundItemsPage()]),
          bottomNavigationBar: buildBottomNavigator(context, _selectedindex)),
    );
  }
}





/* 
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
            icon: const Icon(
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
            icon: const Icon(
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
            icon: const Icon(
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
            icon: const Icon(
              Icons.home_rounded,
            ),
            onPressed: () {
              //show both found and losts
            },
          ),
        )
      ],
    );
  }*/