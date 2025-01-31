import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.go('/basic');
            },
            child: Text('Go To Basic Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              // context.go('/named'); -> 이것도 가능
              context.goNamed('named_screen'); // 이름을 통해 스크린 이동
            },
            child: Text('Go To Named Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              context.goNamed('push_screen'); // 이름을 통해 스크린 이동
            },
            child: Text('Go To Push Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/pop');
            },
            child: Text('Go To Pop Base Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/path_param/456');
            },
            child: Text('Go To PathParam Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/query_param');
            },
            child: Text('Go To QueryParam Screen'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/nested/a');
            },
            child: Text('Go To Nested Screen'),
          ),
        ],
      ),
    );
  }
}
