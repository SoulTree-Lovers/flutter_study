import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          ElevatedButton(
            onPressed: () {
              context.push('/basic'); // Push로 이동 후, 뒤로가기 버튼을 누르면 이전 스크린으로 이동
            },
            child: Text('Push Basic'),
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/basic'); // Go로 이동 후, 뒤로가기 버튼을 누르면 최상위 스크린으로 이동
            },
            child: Text('Go Basic'),
          ),
        ],
      ),
    );
  }
}
