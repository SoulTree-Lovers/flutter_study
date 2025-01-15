import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/layout/main_layout.dart';
import 'package:section29_scrollable_widgets/screen/custom_scroll_view_screen.dart';
import 'package:section29_scrollable_widgets/screen/grid_view_screen.dart';
import 'package:section29_scrollable_widgets/screen/list_view_screen.dart';
import 'package:section29_scrollable_widgets/screen/refresh_indicator_screen.dart';
import 'package:section29_scrollable_widgets/screen/reorderable_list_view_screen.dart';
import 'package:section29_scrollable_widgets/screen/scrollbar_screen.dart';
import 'package:section29_scrollable_widgets/screen/single_child_scroll_view_screen.dart';

class HomeScreen extends StatelessWidget {
  final screens = [
    ScreenModel(
      title: 'SingleChildScrollViewScreen',
      builder: (_) => SingleChildScrollViewScreen(),
    ),
    ScreenModel(
      title: 'ListViewScreen',
      builder: (_) => ListViewScreen(),
    ),
    ScreenModel(
      title: 'GridViewScreen',
      builder: (_) => GridViewScreen(),
    ),
    ScreenModel(
      title: 'ReorderableListViewScreen',
      builder: (_) => ReorderableListViewScreen(),
    ),
    ScreenModel(
      title: 'CustomScrollViewScreen',
      builder: (_) => CustomScrollViewScreen(),
    ),
    ScreenModel(
      title: 'ScrollbarScreen',
      builder: (_) => ScrollbarScreen(),
    ),
    ScreenModel(
      title: 'RefreshIndicatorScreen',
      builder: (_) => RefreshIndicatorScreen(),
    ),
  ];

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'home',
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: screens
                .map(
                  (screen) => ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: screen.builder),
                      );
                    },
                    child: Text(
                      screen.title,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class ScreenModel {
  final String title;
  final WidgetBuilder builder;

  ScreenModel({
    required this.title,
    required this.builder,
  });
}
