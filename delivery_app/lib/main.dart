import 'package:delivery_app/common/component/custom_text_form_field.dart';
import 'package:delivery_app/common/provider/go_router.dart';
import 'package:delivery_app/common/secure_storage/secure_storage.dart';
import 'package:delivery_app/common/view/splash_screen.dart';
import 'package:delivery_app/domain/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import 'domain/user/provider/auth_provider.dart';

final logger = Logger();

void main() {
  runApp(
    ProviderScope(
      child: _App(),
    ),
  );
}

class _App extends ConsumerWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      theme: ThemeData(
        fontFamily: 'NotoSans',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue, // 기본 테마 색상
          background: Colors.white, // 기존 backgroundColor 대체
        ),
        scaffoldBackgroundColor: Colors.white, // 기본 배경색 지정
      ),
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
