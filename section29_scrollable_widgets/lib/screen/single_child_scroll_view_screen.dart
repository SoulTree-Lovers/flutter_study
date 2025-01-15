import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/const/colors.dart';
import 'package:section29_scrollable_widgets/layout/main_layout.dart';

class SingleChildScrollViewScreen extends StatelessWidget {
  // 0~100까지 수 리스트 자동 생성
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  SingleChildScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      title: 'SingleChildScrollView',
      body: renderPerformance(),
    );
  }

  // 1. 기본 스크롤 뷰
  Widget renderSimple() {
    return SingleChildScrollView(
      child: Column(
        children: rainbowColors
            .map((color) => renderContainer(color: color))
            .toList(),
      ),
    );
  }

  // 2. 화면을 넘어 가지 않아도 스크롤 되게 하기
  Widget renderAlwaysScroll() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 3. 화면을 넘어가도 스크롤되게 하고, 컨테이너가 잘리지 않게 하기
  Widget renderClip() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      clipBehavior: Clip.none,
      child: Column(
        children: [
          renderContainer(color: Colors.black),
        ],
      ),
    );
  }

  // 4. 여러가지 스크롤 효과 적용하기
  Widget renderPhysics() {
    return SingleChildScrollView(
      // AlwaysScrollableScrollPhysics(), - 스크롤 가능
      // NeverScrollableScrollPhysics(), - 스크롤 불가능
      // BouncingScrollPhysics(), - iOS 스크롤 효과 적용
      // ClampingScrollPhysics(), - Android 스크롤 효과 적용
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: rainbowColors
            .map((color) => renderContainer(color: color))
            .toList(),
      ),
    );
  }

  // 5. SingleChildScrollView 퍼포먼스 확인하기
  Widget renderPerformance() {
    return SingleChildScrollView(
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
    );
  }

  Widget renderContainer({
    required Color color,
    int? index,
  }) {
    if (index != null) {
      print(index);
    }
    return Container(
      height: 300,
      color: color,
    );
  }
}
