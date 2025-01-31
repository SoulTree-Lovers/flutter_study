import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screens/1_basic_screen.dart';
import 'package:go_router_v7/screens/root_screen.dart';

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
      ],
    ),
  ],
);
