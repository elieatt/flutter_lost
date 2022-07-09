import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigator(
    BuildContext context, int _selectedindex) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: _selectedindex,
    items: [
      BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.mail),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, '/messages');
          },
        ),
        label: ('notification'),
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        label: ('home'),
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.add_box),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/add');
          },
        ),
        label: 'add',
      )
    ],
  );
}
