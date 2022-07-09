import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigator(
    BuildContext context, int _selectedindex, void Function(int) onTapped) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: _selectedindex,
    // onTap: onTapped,
    items: [
      /*  BottomNavigationBarItem(
        icon: IconButton(
          icon: Icon(Icons.mail),
          onPressed: () {
            // Navigator.pushReplacementNamed(context, '/messages');
          },
        ),
        label: ('notification'),
      ), */
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            onTapped(0);
          },
        ),
        label: ('home'),
      ),
      BottomNavigationBarItem(
        icon: IconButton(
          icon: const Icon(Icons.add_box),
          onPressed: () {
            onTapped(1);
          },
        ),
        label: 'add',
      )
    ],
  );
}
