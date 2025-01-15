import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/const/colors.dart';
import 'package:section29_scrollable_widgets/layout/main_layout.dart';

class GridViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  GridViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'GridViewScreen',
      body: renderDefault(),
    );
  }

  // 1. 기본 그리드 뷰 (한 번에 전부 생성)
  Widget renderDefault() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      scrollDirection: Axis.vertical,
      children: numbers
          .map(
            (index) => renderContainer(
              color: rainbowColors[index % rainbowColors.length],
              index: index,
            ),
          )
          .toList(),
    );
  }

  // 2. 고정 그리드 뷰 빌더 (화면에 보일 때마다 생성 -> 메모리 절약)
  Widget renderBuilderCrossAxisCount() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      itemCount: 100,
    );
  }

  // 3. 최대 너비를 설정하는 그리드 뷰 (화면에 보일 때마다 생성 -> 메모리 절약)
  Widget renderBuilderMaxCrossAxisExtent() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 100, // 각 위젯의 최대 너비
      ),
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      itemCount: 100,
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
