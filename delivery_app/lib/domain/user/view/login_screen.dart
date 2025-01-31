import 'dart:convert';
import 'dart:io';

import 'package:delivery_app/common/const/colors.dart';
import 'package:delivery_app/common/const/data.dart';
import 'package:delivery_app/common/layout/default_layout.dart';
import 'package:delivery_app/common/secure_storage/secure_storage.dart';
import 'package:delivery_app/common/view/root_tab.dart';
import 'package:delivery_app/domain/user/model/user_model.dart';
import 'package:delivery_app/domain/user/provider/user_me_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../common/component/custom_text_form_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  static String get routeName => '/login';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(userMeProvider);

    return DefaultLayout(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        onVerticalDragDown: (_) => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            top: true,
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _Title(),
                  SizedBox(height: 16),
                  _SubTitle(),
                  Image.asset(
                    'asset/img/misc/logo.png',
                    width: MediaQuery.of(context).size.width * 0.67,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    hintText: '이메일을 입력해주세요',
                    onChanged: (String value) {
                      username = value;
                      print('username: $username');
                    },
                    isAutoFocus: true,
                  ),
                  SizedBox(height: 16),
                  CustomTextFormField(
                    hintText: '비밀번호를 입력해주세요',
                    onChanged: (String value) {
                      password = value;
                      print('password: $password');
                    },
                    isObscureText: true,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: state is UserModelLoading // 로딩 중이면 버튼 비활성화
                        ? null
                        : () async {
                            ref.read(userMeProvider.notifier).login(
                                  username: username,
                                  password: password,
                                );

                            /*// ID:PASSWORD를 Base64로 인코딩
                      final rawString = '$username:$password';
                      print('rawString: $rawString');

                      Codec<String, String> stringToBase64 = utf8.fuse(base64);
                      String token = stringToBase64.encode(rawString);

                      final response = await dio.post(
                        'http://$ip/auth/login',
                        options: Options(
                          headers: {
                            'authorization': 'Basic $token',
                          },
                        ),
                      );

                      final accessToken = response.data['accessToken'];
                      final refreshToken = response.data['refreshToken'];

                      final flutterSecureStorage = ref.read(secureStorageProvider);

                      await flutterSecureStorage.write(key: REFRESH_TOKEN_KEY, value: refreshToken);
                      await flutterSecureStorage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

                      print(response.data);

                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => RootTab()));*/
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: PRIMARY_COLOR,
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      '로그인',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: PRIMARY_COLOR,
                    ),
                    child: Text(
                      '회원가입',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '환영합니다!',
      style: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  const _SubTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요!\n오늘도 성공적인 주문이 되길 :)',
      style: TextStyle(
        fontSize: 16,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
