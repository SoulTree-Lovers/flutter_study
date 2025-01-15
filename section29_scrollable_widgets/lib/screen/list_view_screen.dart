import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/const/colors.dart';
import 'package:section29_scrollable_widgets/layout/main_layout.dart';

class ListViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  ListViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ListViewScreen',
      body: renderDefault(),
    );
  }

  // 1. 기본 리스트 뷰 (한번에 모든 위젯 생성)
  Widget renderDefault() {
    return ListView(
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

  // 2. 리스트 뷰 빌더 (화면에 보일 때마다 생성 -> 메모리 절약)
  Widget renderBuilder() {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
    );
  }

  // 3. 위젯 중간에 위젯을 추가할 수 있음. (ex. 광고 배너)
  Widget renderSeparated() {
    return ListView.separated(
      itemCount: 100,
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[index % rainbowColors.length],
          index: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        // 5개 마다 광고 배너 보여주기
        if (index % 5 == 0 && index != 0) {
          return renderContainer(
              color: Colors.black, index: index, height: 100);
        }
        return Divider(
          color: Colors.black,
          height: 1,
        );
      },
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
