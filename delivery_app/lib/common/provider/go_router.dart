import 'package:delivery_app/domain/user/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // watch: 값이 변경될 때마다 다시 빌드
  // read: 처음 한 번만 읽고 값이 변경되어도 다시 빌드하지 않음
  final provider = ref.read(authProvider); // 항상 같은 GoRouter 인스턴스를 사용하기 위해 ref.read 사용

  return GoRouter(
    routes: provider.routes,
    initialLocation: '/splash',
    refreshListenable: provider,
    redirect: (context, state) => provider.redirectLogic(context, state),
  );
});
