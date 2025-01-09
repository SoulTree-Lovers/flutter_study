import 'package:flutter/material.dart';
import 'package:section22_navigation/layout/default_layout.dart';

class RouteThreeScreen extends StatelessWidget {
  const RouteThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    return DefaultLayout(
      title: 'Route Three Screen',
      children: [
        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "뒤로가기",
          ),
        ),
        Text("argument: ${arguments.toString()}"),
      ],
    );
  }
}
