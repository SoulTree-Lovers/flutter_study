import 'package:delivery_app/common/component/custom_text_form_field.dart';
import 'package:delivery_app/common/view/splash_screen.dart';
import 'package:delivery_app/domain/user/view/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSans',
      ),
      home: SplashScreen(),
    );
  }
}

