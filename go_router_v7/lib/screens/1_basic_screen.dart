import 'package:flutter/material.dart';
import 'package:go_router_v7/layout/default_layout.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Center(
        child: Text('basic screen'),
      ),
    );
  }
}
