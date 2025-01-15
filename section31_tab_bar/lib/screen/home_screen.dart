import 'package:flutter/material.dart';
import 'package:section31_tab_bar/screen/appbar_using_controller_screen.dart';
import 'package:section31_tab_bar/screen/bottom_navigation_bar_screen.dart';

import 'basic_appbar_tabbar_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return BasicAppbarTabbarScreen();
                  }),
                );
              },
              child: Text(
                'Basic AppBar TabBar Screen',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return AppbarUsingControllerScreen();
                  }),
                );
              },
              child: Text(
                'AppBar Controller Screen',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) {
                    return BottomNavigationBarScreen();
                  }),
                );
              },
              child: Text(
                'Bottom Navigation Bar Screen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
