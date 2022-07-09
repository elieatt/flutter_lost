import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/presentation/pages/found_items_pages.dart';
import 'package:lostsapp/presentation/pages/missing_items_page.dart';
import 'package:lostsapp/presentation/widgets/app_bar.dart';
import '../../data/repositories/post_and_update_network_repository.dart';
import '../../logic/cubit/post_item_cubit.dart';
import '../widgets/bottombar.dart';
import '../widgets/drawer.dart';
import 'add_page.dart';

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
  late TabController _homePageTabController;

  final PageController _pageController = PageController();
  void onTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    _homePageTabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _homePageTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: buildAppBar(_selectedindex, _homePageTabController),
      body: PageView(
        controller: _pageController,
        children: [
          TabBarView(
              controller: _homePageTabController,
              children: [const MissingPage(), FoundItemsPage()]),
          BlocProvider<PostItemCubit>(
            lazy: false,
            create: (context) => PostItemCubit(AddnUpdateRepository()),
            child: AddPage(
              onTapped: onTapped,
            ),
          ),
        ],
      ),
      bottomNavigationBar:
          buildBottomNavigator(context, _selectedindex, onTapped),
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