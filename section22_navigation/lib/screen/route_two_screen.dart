import 'package:flutter/material.dart';
import 'package:section22_navigation/layout/default_layout.dart';
import 'package:section22_navigation/screen/route_three_screen.dart';

class RouteTwoScreen extends StatelessWidget {
  const RouteTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments; // 데이터를 받아오는 방법 (외우기)

    return DefaultLayout(
      title: 'Route Two Screen',
      children: [
        Text(
          "argument: ${arguments.toString()}",
          textAlign: TextAlign.center,
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "뒤로가기",
          ),
        ),
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/three',
              arguments: 111111,
            );
          },
          child: Text(
            "Route Three로 이동",
          ),
        ),
        OutlinedButton(
          onPressed: () {
            /// [HomeScreen, RouteOneScreen, RouteTwoScreen]
            /// push - [HomeScreen, RouteOneScreen, RouteTwoScreen, RouteThreeScreen]
            /// pushR - [HomeScreen, RouteOneScreen, RouteThreeScreen] -> 이전화면을 없애고 이동
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return RouteThreeScreen();
                },
                settings: RouteSettings(arguments: 999),
              ),
            );
          },
          child: Text("Push Replacement"),
        ),
        OutlinedButton(
          onPressed: () {
            /// [HomeScreen, RouteOneScreen, RouteTwoScreen]
            /// push - [HomeScreen, RouteOneScreen, RouteTwoScreen, RouteThreeScreen]
            /// pushR - [HomeScreen, RouteOneScreen, RouteThreeScreen] -> 이전화면을 없애고 이동
            Navigator.of(context).pushReplacementNamed(
              '/three',
              arguments: 999,
            );
          },
          child: Text("Push Replacement Named"),
        ),
        OutlinedButton(
          onPressed: () {
            /// [HomeScreen, RouteOneScreen, RouteTwoScreen]
            /// push - [HomeScreen, RouteOneScreen, RouteTwoScreen, RouteThreeScreen]
            /// pushR - [HomeScreen, RouteOneScreen, RouteThreeScreen] -> 이전화면을 없애고 이동
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/three',
              (route) {
                /// 만약에 삭제 할거면 (Route Stack) false 반환
                /// 만약에 삭제를 안 할거면 true 반환
                return route.settings.name == '/'; // HomeScreen 이전의 모든 화면을 삭제하고 RouteThreeScreen으로 이동
              },
              arguments: 999,
            );
          },
          child: Text("Push Named And Remove Until"),
        ),
      ],
    );
  }
}
