import 'dart:async';

import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/common/view/splash_screen.dart';
import 'package:delivery_app/domain/restaurant/view/restaurant_detail_screen.dart';
import 'package:delivery_app/domain/user/model/user_model.dart';
import 'package:delivery_app/domain/user/provider/user_me_provider.dart';
import 'package:delivery_app/domain/user/view/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>((ref) {
  return AuthProvider(ref: ref);
});

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({required this.ref}) {
    ref.listen<UserModelBase?>(userMeProvider, (previous, next) {
      if (previous != next) {
        notifyListeners();
      }
    });
  }

  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (_, __) => RootTab(),
          routes: [
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (_, state) => RestaurantDetailScreen(
                id: state.pathParameters['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (_, __) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (_, __) => LoginScreen(),
        ),
      ];

  void logout() {
    ref.read(userMeProvider.notifier).logout();
  }

  // SplashScreen
  // 앱을 처음 시작했을 때 토큰이 존재하는지 확인 후, 로그인 스크린으로 보낼지 홈 스크린으로 보낼지 확인하는 과정이 필요하다.
  // GoRouter v14에 맞게 수정함
  FutureOr<String?> redirectLogic(BuildContext context, GoRouterState state) async {
    final UserModelBase? user = ref.read(userMeProvider);
    final logginIn = state.matchedLocation == '/login'; // 현재 위치가 로그인 페이지인지 확인

    // 유저 정보가 없는데 로그인 중이면 그대로 로그인 페이지에 두고
    // 로그인 중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // 유저 정보가 있으면
    // 로그인 중이거나 현재 위치가 Splash 화면이라면
    // 홈 화면으로 이동
    if (user is UserModel) {
      return logginIn || state.matchedLocation == '/splash' ? '/' : null;
    }

    // UserModelError
    if (user is UserModelError) {
      return logginIn ? null : '/login';
    }

    // 그 외의 경우는 원래 가려던 곳으로 이동
    return null;
  }
}
