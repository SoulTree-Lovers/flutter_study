import 'package:flutter/material.dart';
import 'package:section29_scrollable_widgets/const/colors.dart';

class CustomScrollViewScreen extends StatelessWidget {
  final List<int> numbers = List.generate(
    100,
    (index) => index,
  );

  CustomScrollViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          renderSliverAppBar(),
          renderHeader(),
          renderChildSliverList(),
          renderHeader(),
          renderBuilderSliverList(),
          renderHeader(),
          renderChildSliverGrid(),
          renderHeader(),
          renderBuilderSliverGrid(),
        ],
      ),
    );
  }

  // AppBar
  SliverAppBar renderSliverAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.greenAccent,
      floating: true,
      // 스크롤을 내릴 때 AppBar가 사라지지 않고 화면 상단에 나타나게 할 수 있음.
      pinned: false,
      // 스크롤을 내릴 때 AppBar가 화면 상단에 고정되게 할 수 있음. (기본 앱바)
      snap: true,
      // 조금만 움직여도 앱바가 나타나거나 사라지게 할 수 있음. (floating이 true일 때만 사용 가능)
      stretch: true,
      // 스크롤을 내릴 때 AppBar가 확장되게 할 수 있음.
      expandedHeight: 200,
      // AppBar가 확장될 최대 높이
      collapsedHeight: 100,
      // AppBar가 축소될 최소 높이
      flexibleSpace: FlexibleSpaceBar(
        background: Image.asset(
          'asset/img/image_1.jpeg',
          fit: BoxFit.cover,
        ),
        title: Text('FlexibleSpaceBar'),
      ),
      title: Text(
        'CustomScrollViewScreen',
      ),
    );
  }

  // Header
  SliverPersistentHeader renderHeader() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverFixedHeaderDelegate(
        child: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              'Header',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        minHeight: 100,
        maxHeight: 200,
      ),
    );
  }

  // 1. 기본 슬리버 리스트
  SliverList renderChildSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (index) => renderContainer(
                color: rainbowColors[index % rainbowColors.length],
                index: index,
              ),
            )
            .toList(),
      ),
    );
  }

  // 2. 빌더를 사용한 슬리버 리스트
  SliverList renderBuilderSliverList() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
    );
  }

  // 3. 그리드 뷰 슬리버
  SliverGrid renderChildSliverGrid() {
    return SliverGrid(
      delegate: SliverChildListDelegate(
        numbers
            .map(
              (index) => renderContainer(
                color: rainbowColors[index % rainbowColors.length],
                index: index,
              ),
            )
            .toList(),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
    );
  }

  // 4. 빌더를 사용한 그리드 뷰 슬리버
  SliverGrid renderBuilderSliverGrid() {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return renderContainer(
            color: rainbowColors[index % rainbowColors.length],
            index: index,
          );
        },
        childCount: 100,
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 150,
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

class _SliverFixedHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double maxHeight;
  final double minHeight;

  _SliverFixedHeaderDelegate({
    required this.child,
    required this.maxHeight,
    required this.minHeight,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight; // 최대 높이

  @override
  double get minExtent => minHeight; // 최소 높이

  @override
  // covariant: 자식 클래스에서 부모 클래스의 타입을 변경할 수 있음.
  // oldDelegate: 이전 위젯의 델리게이트
  // this: 현재 위젯의 델리게이트
  // shouldRebuild: 이전 위젯과 현재 위젯이 다른지 확인하고 새로 빌드할지 결정 (true: 새로 빌드, false: 새로 빌드하지 않음)
  bool shouldRebuild(_SliverFixedHeaderDelegate oldDelegate) {
    return oldDelegate.minHeight != minHeight ||
        oldDelegate.maxHeight != maxHeight ||
        oldDelegate.child != child;
  }
}
