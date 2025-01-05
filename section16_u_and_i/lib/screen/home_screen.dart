import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime(2000, 1, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        // 안전한 영역을 주는 위젯
        top: true,
        // 상단 여백을 주는지 여부
        bottom: true,
        // 하단 여백을 주는지 여부
        left: true,
        // 좌측 여백을 주는지 여부
        right: true,
        // 우측 여백을 주는지 여부
        child: SizedBox(
          width: MediaQuery.of(context).size.width, // 화면의 가로 길이
          child: Column(
            children: [
              _Top(
                selectedDate: selectedDate,
                onPressed: onHeartPressed,
              ),
              _Bottom(),
            ],
          ),
        ),
      ),
    );
  }

  // 하트 버튼 클릭 시 이벤트 (날짜 선택 다이얼로그)
  void onHeartPressed() {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true, // 다이얼로그 외부 터치 시 닫힘 여부
      builder: (BuildContext context) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            color: Colors.white,
            height: 200,
            child: CupertinoDatePicker(
              maximumDate: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              initialDateTime: selectedDate,
              dateOrder: DatePickerDateOrder.ymd,
              onDateTimeChanged: (DateTime date) {
                setState(() {
                  selectedDate = date;
                  print(selectedDate);
                });
              },
            ),
          ),
        );
      },
    );
  }
}

class _Top extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback? onPressed;

  const _Top({
    super.key,
    required this.selectedDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    var textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Text(
            "U & I",
            style: textTheme.displayLarge,
          ),
          Text(
            "우리 처음 만난 날",
            style: textTheme.bodyLarge,
          ),
          Text(
            "${selectedDate.year}.${selectedDate.month}.${selectedDate.day}",
            style: textTheme.bodyMedium,
          ),
          IconButton(
            onPressed: onPressed,
            iconSize: 40,
            color: Colors.red[300],
            icon: Icon(
              Icons.favorite,
            ),
          ),
          Text(
            "D + ${now.difference(selectedDate).inDays + 1}",
            style: textTheme.displayMedium,
          ),
        ],
      ),
    );
  }
}

class _Bottom extends StatelessWidget {
  const _Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image.asset("asset/img/middle_image.png"),
    );
  }
}
