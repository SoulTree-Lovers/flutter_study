import 'dart:math';

import 'package:flutter/material.dart';
import 'package:section19_random_number_generator/component/number_to_image.dart';
import 'package:section19_random_number_generator/constant/color.dart';
import 'package:section19_random_number_generator/screen/setting_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<int> numbers = [
    123,
    456,
    789,
  ];

  int maxNumber = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// 제목과 아이콘
              _Header(
                onPressed: _onSettingPressed,
              ),

              /// 숫자
              _Body(
                numbers: numbers,
              ),

              /// 버튼
              _Footer(
                onPressed: _generateRandomNumber,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _generateRandomNumber() {
    final random = Random();
    final Set<int> newNumbers = {};

    while (newNumbers.length < 3) {
      final randomNumber = random.nextInt(maxNumber);
      newNumbers.add(randomNumber);
    }

    print(newNumbers);
    setState(() {
      numbers = newNumbers.toList();
    });
  }

  Future<void> _onSettingPressed() async {
    final result = await Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        return SettingScreen(
          maxNumber: maxNumber,
        );
      }),
    );
    maxNumber = result;
    print(result);
  }
}

class _Header extends StatelessWidget {
  final VoidCallback onPressed;

  const _Header({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "랜덤 숫자 생성기",
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        IconButton(
          color: redColor,
          onPressed: onPressed,
          icon: Icon(
            Icons.settings,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final List<int> numbers;

  const _Body({
    super.key,
    required this.numbers,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: numbers.map((e) => NumberToImage(number: e)).toList(),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onPressed;

  const _Footer({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: redColor,
        foregroundColor: Colors.white,
      ),
      child: Text(
        "생성하기!",
      ),
    );
  }
}
