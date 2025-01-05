import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? timer;
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      int currentPage = pageController.page!.toInt();
      int nextPage = currentPage + 1;

      if (nextPage > 4) {
        nextPage = 0;
      }

      pageController.animateToPage(nextPage, duration: Duration(seconds: 1), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    super.dispose();

    timer?.cancel();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Image Carousel'),
      ),
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5] // Add this line
            .map(
              (e) => Image.asset(
                "asset/img/image_$e.jpeg",
                fit: BoxFit.fill,
              ),
            )
            .toList(),
      ),
    );
  }
}
