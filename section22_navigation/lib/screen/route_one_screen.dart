import 'package:flutter/material.dart';
import 'package:section22_navigation/layout/default_layout.dart';
import 'package:section22_navigation/screen/route_two_screen.dart';

class RouteOneScreen extends StatelessWidget {
  final int number;

  const RouteOneScreen({
    super.key,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // canPop: Pop 가능 여부 설정
      child: DefaultLayout(
        title: "Route One Screen",
        children: [
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop(
                123,
              );
            },
            child: Text("뒤로가기"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).maybePop(
                123,
              );
            },
            child: Text("Maybe Pop"),
          ),
          OutlinedButton(
            onPressed: () {
              var canPop = Navigator.of(context).canPop(); // canPop(): Pop 가능 여부 확인
              print(canPop);
            },
            child: Text("Can Pop"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RouteTwoScreen();
                  },
                  settings: RouteSettings(
                    arguments: number,
                  ),
                ),
              );
            },
            child: Text("Route Two로 이동"),
          ),
          Text(
            "argument: $number",
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
