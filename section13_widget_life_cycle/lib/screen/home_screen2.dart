import 'package:flutter/material.dart';

// TODO: Stateful Widget Life Cycle
class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  Color color = Colors.red;
  bool show = false;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (show) GestureDetector(
              onTap: () {
                setState(() {
                  color = color == Colors.red ? Colors.blue : Colors.red;
                });
              },
              child: CodeFactoryWidget(
                color: color,
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            ElevatedButton(
              onPressed: () {
                count++;
                print("클릭! count: $count");
                setState(() {
                  show = !show;
                });
              },
              child: Text("보이기/숨기기"),
            ),
          ],
        ),
      ),
    );
  }
}

class CodeFactoryWidget extends StatefulWidget {
  final Color color;

  CodeFactoryWidget({
    super.key,
    required this.color,
  }) {
    print("1) 생성자 실행");
  }

  @override
  State<CodeFactoryWidget> createState() {
    print("2) createState 실행");
    return _CodeFactoryWidgetState();
  }
}

class _CodeFactoryWidgetState extends State<CodeFactoryWidget> {
  @override
  void initState() {
    print("3) initState 실행");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("4) didChangeDependencies 실행");
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print("5) build 실행");

    return Container(
      color: widget.color,
      width: 50,
      height: 50,
    );
  }

  @override
  void deactivate() {
    print("6) deactivate 실행");
    super.deactivate();
  }

  @override
  void dispose() {
    print("7) dispose 실행");
    super.dispose();
  }
}
