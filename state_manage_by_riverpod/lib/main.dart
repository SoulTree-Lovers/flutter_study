import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_manage_by_riverpod/riverpod/provider_observer.dart';
import 'package:state_manage_by_riverpod/screen/home_screen.dart';

void main() {
  runApp(
    ProviderScope( // 상태관리를 사용하기 위해 추가
      observers: [
        Logger(),
      ],
      child: MaterialApp(
        home: HomeScreen(),
      ),
    ),
  );
}
