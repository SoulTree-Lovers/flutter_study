import 'package:delivery_app/common/const/data.dart'; // 데이터 상수를 가져옴
import 'package:delivery_app/common/secure_storage/secure_storage.dart';
import 'package:delivery_app/domain/user/provider/auth_provider.dart';
import 'package:delivery_app/domain/user/provider/user_me_provider.dart';
import 'package:dio/dio.dart'; // Dio 패키지를 가져옴
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Flutter Secure Storage 패키지를 가져옴

final dioProvider = Provider<Dio>((ref) {
  // Dio 인스턴스를 생성하는 Provider
  final dio = Dio();

  final flutterSecureStorage = ref.watch(secureStorageProvider);

  dio.interceptors.add(
    CustomInterceptor(
      flutterSecureStorage: flutterSecureStorage,
      ref: ref,
    ),
  );

  return dio;
});

class CustomInterceptor extends Interceptor {
  // CustomInterceptor 클래스는 Interceptor를 상속받음
  final FlutterSecureStorage
      flutterSecureStorage; // FlutterSecureStorage 인스턴스를 저장할 변수
  final Ref ref;

  CustomInterceptor({
    // CustomInterceptor 생성자
    required this.flutterSecureStorage, // flutterSecureStorage를 필수로 받음
    required this.ref,
  });

  // 1. 요청 보낼 때
  // 요청이 보내질 때마다 만약 헤더에 accessToken 값이 true로 되어있으면
  // accessToken을 읽어와서 헤더에 추가해준다.
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 요청을 가로챌 때 실행되는 메서드
    print(
        '[REQ] ${options.method} ${options.uri} ${options.data}'); // 요청 정보를 출력

    if (options.headers['accessToken'] == 'true') {
      // 헤더에 accessToken이 true로 설정되어 있으면
      options.headers.remove('accessToken'); // 헤더에서 accessToken을 삭제
      final accessToken = await flutterSecureStorage.read(
          key: ACCESS_TOKEN_KEY); // accessToken을 읽어옴
      print('accessToken: ${accessToken.toString()}'); // accessToken을 출력
      options.headers.addAll({
        // 헤더에 accessToken을 추가
        'authorization': 'Bearer $accessToken',
      });
    }

    if (options.headers['refreshToken'] == 'true') {
      // 헤더에 refreshToken이 true로 설정되어 있으면
      options.headers.remove('refreshToken'); // 헤더에서 refreshToken을 삭제
      final refreshToken = await flutterSecureStorage.read(
          key: REFRESH_TOKEN_KEY); // refreshToken을 읽어옴
      print('refreshToken: ${refreshToken.toString()}'); // refreshToken을 출력
      options.headers.addAll({
        // 헤더에 refreshToken을 추가
        'authorization': 'Bearer $refreshToken',
      });
    }

    return super.onRequest(options, handler); // 부모 클래스의 onRequest 메서드를 호출
  }

  // 2. 응답 받을 때
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 응답을 가로챌 때 실행되는 메서드
    print(
        '[RES] ${response.requestOptions.method} ${response.requestOptions.uri} ${response.requestOptions.data}'); // 요청 정보를 출력

    super.onResponse(response, handler); // 부모 클래스의 onResponse 메서드를 호출
  }

  // 3. 에러가 났을 때 (JWT 토큰 갱신 로직)
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // 에러를 가로챌 때 실행되는 메서드
    print(
        '[ERR] ${err.requestOptions.method} ${err.requestOptions.uri} ${err.response?.data}'); // 에러 정보를 출력

    final refreshToken = await flutterSecureStorage.read(
        key: REFRESH_TOKEN_KEY); // refreshToken을 읽어옴

    if (refreshToken == null) {
      // refreshToken이 없으면
      return handler.reject(err); // 에러를 발생시킴
    }

    final isStatus401 = err.response?.statusCode == 401; // 에러 상태 코드가 401인지 확인
    final isPathRefresh =
        err.requestOptions.path == '/auth/token'; // 요청 경로가 토큰 재발급 요청인지 확인

    if (isStatus401 && !isPathRefresh) {
      // 401 에러이고 토큰 재발급 요청이 아니면
      final dio = Dio(); // 새로운 Dio 인스턴스를 생성
      try {
        final response = await dio.post(
          // 토큰 재발급 요청을 보냄
          'http://$ip/auth/token',
          options: Options(headers: {
            'authorization': 'Bearer $refreshToken',
          }),
        );

        final newAccessToken =
            response.data['accessToken']; // 새로운 accessToken을 받음
        final options = err.requestOptions; // 원래 요청 옵션을 가져옴

        options.headers.addAll({
          // 헤더에 새로운 accessToken을 추가
          'authorization': 'Bearer $newAccessToken',
        });

        await flutterSecureStorage.write(
            key: ACCESS_TOKEN_KEY,
            value: newAccessToken); // 새로운 accessToken을 저장

        final newResponse = await dio.fetch(options); // 원래 요청을 다시 보냄

        return handler.resolve(newResponse); // 새로운 응답을 반환
      } on DioException catch (e) {
        // 에러가 발생하면
        ref.read(authProvider.notifier).logout(); // 로그아웃을 실행 (이 방법은 circular dependency 문제 발생)

        return handler.reject(err); // 에러를 발생시킴
      }
    }

    return handler.reject(err); // 에러를 발생시킴

    super.onError(err, handler); // 부모 클래스의 onError 메서드를 호출
  }
}
