import 'package:flutter/material.dart';
import 'package:section16_u_and_i/screen/home_screen.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          displayLarge: TextStyle(
            fontFamily: "Parisienne",
            fontSize: 60,
            color: Colors.black,
          ),
          displayMedium: TextStyle(
            fontFamily: "Sunflower",
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontFamily: "Sunflower",
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
          bodyMedium: TextStyle(
            fontFamily: "Sunflower",
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w300,
          ),
        ),
        fontFamily: "Sunflower",
      ),
      home: HomeScreen(),
    ),
  );
}
