import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/const/colors.dart';
import 'package:section29_scrollable_widgets/layout/main_layout.dart';

class ScrollbarScreen extends StatelessWidget {
  List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  ScrollbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ScrollbarScreen',
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: numbers
                .map(
                  (number) => renderContainer(
                    color: rainbowColors[number % rainbowColors.length],
                    index: number,
                  ),
                )
                .toList(),
          ),
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
