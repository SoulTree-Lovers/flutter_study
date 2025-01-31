import 'package:delivery_app/common/const/data.dart';
import 'package:delivery_app/common/secure_storage/secure_storage.dart';
import 'package:delivery_app/domain/user/repository/auth_repository.dart';
import 'package:delivery_app/domain/user/repository/user_me_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/user_model.dart';

final userMeProvider = StateNotifierProvider<UserMeStateNotifier, UserModelBase?>((ref) {
  final userMeRepository = ref.watch(userMeRepositoryProvider);
  final storage = ref.watch(secureStorageProvider);
  final authRepository = ref.watch(authRepositoryProvider);

  return UserMeStateNotifier(
    userMeRepository: userMeRepository,
    storage: storage,
    authRepository: authRepository,
  );
});

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final UserMeRepository userMeRepository;
  final FlutterSecureStorage storage;
  final AuthRepository authRepository;

  UserMeStateNotifier({
    required this.userMeRepository,
    required this.storage,
    required this.authRepository,
  }) : super(UserModelLoading()) {
    getMe(); // 내 정보 가져오기
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    if (refreshToken == null || accessToken == null) {
      state = null; // 로그아웃 상태 (토큰이 없는 상태)
      return;
    }

    final response = await userMeRepository.getMe();

    state = response; // UserModel
  }

  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final response = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: response.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: response.refreshToken);

      final userResponse = await userMeRepository.getMe();

      state = userResponse;

      return userResponse;
    } catch (e) {
      state = UserModelError(message: '로그인에 실패하였습니다.');
      print(e);
      return Future.value(state);
    }
  }

  Future<void> logout() async {
    state = null; // 로그아웃 상태로 변경

    await Future.wait([ // 여러 개의 Future를 동시에 실행
      storage.delete(key: ACCESS_TOKEN_KEY),
      storage.delete(key: REFRESH_TOKEN_KEY),
    ]);
  }
}
