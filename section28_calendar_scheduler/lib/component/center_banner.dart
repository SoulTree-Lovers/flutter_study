import 'package:flutter/material.dart';

import '../const/color.dart';

class CenterBanner extends StatelessWidget {
  final DateTime? selectedDay;
  final int taskCount;

  const CenterBanner({
    super.key,
    this.selectedDay,
    required this.taskCount,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "선택한 날짜: ${selectedDay!.year}년 ${selectedDay!.month}월 ${selectedDay!.day}일",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "할 일: $taskCount개",
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
