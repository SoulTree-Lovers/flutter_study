import 'package:flutter/material.dart';
import 'package:section22_navigation/layout/default_layout.dart';
import 'package:section22_navigation/screen/route_one_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "Home Screen",
      children: [
        OutlinedButton(
          onPressed: () async {
            final result = await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return RouteOneScreen(
                    number: 1,
                  );
                },
              ),
            );
            print(result);
          },
          child: Text("Push"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop( // pop(): Pop하려는 화면이 마지막 화면이면 Pop 안 함
              123,
            );
          },
          child: Text("뒤로가기"),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).maybePop( // maybePop(): Pop하려는 화면이 마지막 화면이 아니라면 Pop, 아니면 Pop 안 함
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
      ],
    );
  }
}
