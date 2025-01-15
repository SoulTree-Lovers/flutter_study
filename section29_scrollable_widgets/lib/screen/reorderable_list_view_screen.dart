import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/layout/main_layout.dart';

import '../const/colors.dart';

class ReorderableListViewScreen extends StatefulWidget {
  const ReorderableListViewScreen({super.key});

  @override
  State<ReorderableListViewScreen> createState() =>
      _ReorderableListViewScreenState();
}

class _ReorderableListViewScreenState extends State<ReorderableListViewScreen> {
  List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'ReorderableListViewScreen',
      body: renderDefault(),
    );
  }

  // 1. 기본 Reorder 리스트 뷰 (한번에 모든 위젯 생성)
  Widget renderDefault() {
    return ReorderableListView(
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // [red, orange, yellow]
          // [0, 1, 2]

          // 1. red를 yellow 다음으로 옮기고 싶다.
          // red: 0(oldIndex) -> 3(newIndex) 위치를 옮기기 전 인덱스를 기준으로 산정
          // [orange, yellow, red]

          // 2. yellow를 red 앞으로 옮기고 싶다.
          // yellow: 2(oldIndex) -> 0(newIndex) 위치를 옮기기 전 인덱스를 기준으로 산정
          // [yellow, red, orange]

          // 결론:
          // 1) oldIndex가 newIndex보다 작으면 1을 빼준다.
          // 2) oldIndex가 newIndex보다 크면 그대로 사용한다.

          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
      },
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

  // 2. Reorder 리스트 뷰 빌더 (화면에 보일 때마다 생성 -> 메모리 절약)
  // 재정렬할 때마다 index도 바뀌기 때문에 아래과 같이 코드를 작성해야 한다.
  Widget renderBuilderReorderable() {
    return ReorderableListView.builder(
      itemBuilder: (context, index) {
        return renderContainer(
          color: rainbowColors[numbers[index] % rainbowColors.length],
          index: numbers[index],
        );
      },
      itemCount: numbers.length,
      onReorder: (int oldIndex, int newIndex) {
        setState(() {
          // [red, orange, yellow]
          // [0, 1, 2]

          // 1. red를 yellow 다음으로 옮기고 싶다.
          // red: 0(oldIndex) -> 3(newIndex) 위치를 옮기기 전 인덱스를 기준으로 산정
          // [orange, yellow, red]

          // 2. yellow를 red 앞으로 옮기고 싶다.
          // yellow: 2(oldIndex) -> 0(newIndex) 위치를 옮기기 전 인덱스를 기준으로 산정
          // [yellow, red, orange]

          // 결론:
          // 1) oldIndex가 newIndex보다 작으면 1을 빼준다.
          // 2) oldIndex가 newIndex보다 크면 그대로 사용한다.

          if (oldIndex < newIndex) {
            newIndex -= 1;
          }

          final item = numbers.removeAt(oldIndex);
          numbers.insert(newIndex, item);
        });
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
      key: Key(index.toString()),
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
