import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lostsapp/logic/cubit/auth_cubit.dart';
import 'package:lostsapp/logic/cubit/messages_cubit.dart';

import 'package:lostsapp/presentation/pages/found_items_pages.dart';
import 'package:lostsapp/presentation/pages/messages_page.dart';
import 'package:lostsapp/presentation/pages/missing_items_page.dart';
import 'package:lostsapp/presentation/widgets/home_page_widgets/app_bar.dart';

import '../../data/repositories/post_and_update_network_repository.dart';
import '../../logic/cubit/post_item_cubit.dart';
import '../widgets/home_page_widgets/bottombar.dart';
import '../widgets/home_page_widgets/drawer.dart';

import 'add_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int _selectedindex = 0;

  late TabController _homePageTabController;
  late TabController _messagesPageTabController;
  late PageController _pageController;

  void onTapped(int index) {
    setState(() {
      _selectedindex = index;
    });
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOutQuart);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _homePageTabController = TabController(vsync: this, length: 2);
    _messagesPageTabController = TabController(
      vsync: this,
      length: 2,
    );
    BlocProvider.of<MessagesCubit>(context).getRecivedMessages(
        BlocProvider.of<AuthCubit>(context).getUser().token,
        BlocProvider.of<AuthCubit>(context).getUser().id,
        true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _homePageTabController.dispose();
    _messagesPageTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(context, onTapped, _homePageTabController,
          _messagesPageTabController),
      appBar: buildAppBar(_selectedindex, _homePageTabController,
          _messagesPageTabController, context),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _homePageTabController,
            children: const [MissingPage(), FoundItemsPage()],
          ),
          BlocProvider<PostItemCubit>(
            lazy: false,
            create: (context) => PostItemCubit(AddnUpdateRepository()),
            child: AddPage(
              onTapped: onTapped,
              htb: _homePageTabController,
            ),
          ),
          TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _messagesPageTabController,
              children: const [MessagesPage(index: 0), MessagesPage(index: 1)]),
        ],
      ),
      bottomNavigationBar:
          buildBottomNavigator(context, _selectedindex, onTapped),
    );
  }
}
