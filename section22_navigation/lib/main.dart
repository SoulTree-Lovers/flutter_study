import 'package:flutter/material.dart';
import 'package:section22_navigation/screen/home_screen.dart';
import 'package:section22_navigation/screen/route_one_screen.dart';
import 'package:section22_navigation/screen/route_three_screen.dart';
import 'package:section22_navigation/screen/route_two_screen.dart';

/// Imperative vs Declarative
void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        /// key: 라우트 이름
        /// value: 이동하고 싶은 화면
        '/': (BuildContext context) => HomeScreen(),
        '/one': (BuildContext context) => RouteOneScreen(
              number: 111,
            ),
        '/two': (BuildContext context) => RouteTwoScreen(),
        '/three': (BuildContext context) => RouteThreeScreen(),
      },
    ),
  );
}
