import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screens/1_basic_screen.dart';
import 'package:go_router_v7/screens/3_push_screen.dart';
import 'package:go_router_v7/screens/root_screen.dart';

import '../screens/2_named_screen.dart';

// https://blog.codefactory.ai == /
// https://blog.codefactory.ai/flutter == /flutter (path만 표시)
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => RootScreen(),
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) => BasicScreen(),
        ),
        GoRoute(
          path: 'named',
          name: 'named_screen',
          builder: (context, state) => NamedScreen(),
        ),
        GoRoute(
          path: 'push',
          name: 'push_screen',
          builder: (context, state) => PushScreen(),
        ),
      ],
    ),
  ],
);
