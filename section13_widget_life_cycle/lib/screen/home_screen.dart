import 'package:flutter/material.dart';

// TODO: Stateless Widget Life Cycle
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SecondWidget(),
    );
  }
}

class SecondWidget extends StatelessWidget {
  SecondWidget({super.key}) {
    print("1) 생성자 실행");
  }

  @override
  Widget build(BuildContext context) {
    print("2) 빌드 실행");

    return Center(
      child: Container(
        width: 50,
        height: 50,
        color: Colors.red,
      ),
    );
  }
}
