import 'package:go_router/go_router.dart';
import 'package:go_router_v7/screens/1_basic_screen.dart';
import 'package:go_router_v7/screens/3_push_screen.dart';
import 'package:go_router_v7/screens/4_pop_base_screen.dart';
import 'package:go_router_v7/screens/5_pop_return_screen.dart';
import 'package:go_router_v7/screens/6_path_param_screen.dart';
import 'package:go_router_v7/screens/7_query_param_screen.dart';
import 'package:go_router_v7/screens/8_nested_child_screen.dart';
import 'package:go_router_v7/screens/8_nested_screen.dart';
import 'package:go_router_v7/screens/9_login_screen.dart';
import 'package:go_router_v7/screens/9_private_screen.dart';
import 'package:go_router_v7/screens/root_screen.dart';

import '../screens/2_named_screen.dart';

// 로그인 여부
// true: 로그인 상태, false: 로그아웃 상태
bool authState = false;

// https://blog.codefactory.ai == /
// https://blog.codefactory.ai/flutter == /flutter (path만 표시)
final router = GoRouter(
  redirect: (context, state) {
    // return String (path) -> 해당 경로(/login)로 이동
    // return null -> 원래 이동하려던 화면으로 이통
    if (state.location == '/login/private' && !authState) {
      return '/login';
    }

    return null;
  },
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
        GoRoute(
          path: 'pop',
          builder: (context, state) => PopBaseScreen(),
          routes: [
            GoRoute(
              path: 'return',
              builder: (context, state) => PopReturnScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'path_param/:id', // -> /path_param/123
          builder: (context, state) => PathParamScreen(),
          routes: [
            GoRoute(
              path: ':name', // -> /path_param/123/abc
              builder: (context, state) => PathParamScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) => QueryParamScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) => NestedScreen(child: child),
          routes: [
            GoRoute(
              path: 'nested/a',
              builder: (context, state) =>
                  NestedChildScreen(routeName: '/nested/a'),
            ),
            GoRoute(
              path: 'nested/b',
              builder: (context, state) =>
                  NestedChildScreen(routeName: '/nested/b'),
            ),
            GoRoute(
              path: 'nested/c',
              builder: (context, state) =>
                  NestedChildScreen(routeName: '/nested/c'),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (context, state) => PrivateScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'login2',
          builder: (context, state) => LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (context, state) => PrivateScreen(),
              redirect: (context, state) {
                if (!authState) {
                  return '/login2';
                }
                return null;
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
