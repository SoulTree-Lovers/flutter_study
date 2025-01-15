import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/const/colors.dart';
import 'package:section29_scrollable_widgets/layout/main_layout.dart';

class RefreshIndicatorScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  RefreshIndicatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'RefreshIndicatorScreen',
      body: RefreshIndicator(
        onRefresh: () async {
          // 서버 요청을 통해 데이터를 다시 받아올 때 사용
          await Future.delayed(Duration(seconds: 1));
        },
        child: ListView(
          children: numbers
              .map(
                (index) => renderContainer(
                  color: rainbowColors[index % rainbowColors.length],
                  index: index,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);

    return Container(
      height: height == null ? 300 : height,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
