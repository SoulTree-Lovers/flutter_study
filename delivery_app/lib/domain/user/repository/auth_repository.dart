import 'package:delivery_app/common/model/login_response.dart';
import 'package:delivery_app/common/model/token_response.dart';
import 'package:delivery_app/common/utils/data_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../common/const/data.dart';
import '../../../common/dio/dio.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);

  return AuthRepository(
    dio: dio,
    baseUrl: 'http://$ip/auth',
  );
});

class AuthRepository {
  // http://$ip/auth
  final String baseUrl;
  final Dio dio;

  AuthRepository({
    required this.dio,
    required this.baseUrl,
  });

  Future<LoginResponse> login({
    required String username,
    required String password,
  }) async {
    final serialized = DataUtils.plainToBase64('$username:$password');

    final response = await dio.post(
      '$baseUrl/login',
      options: Options(
        headers: {
          'authorization': 'Basic $serialized',
        },
      ),
    );

    return LoginResponse.fromJson(response.data);
  }

  Future<TokenResponse> token() async {
    final response = await dio.post(
      '$baseUrl/token',
      options: Options(headers: {
        'refreshToken': 'true',
      }),
    );

    return TokenResponse.fromJson(response.data);
  }
}
