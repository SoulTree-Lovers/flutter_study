import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    print("빌드 실행!");

    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (color == Colors.blue) {
                  color = Colors.red;
                } else {
                  color = Colors.blue;
                }
                setState(() {}); // setState()를 호출하여 화면을 다시 그린다.

                print("색상 변경! color: $color");
              },
              child: Text('색상 변경!'),
            ),
            SizedBox(height: 32,),
            Container(
              width: 50,
              height: 50,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}


class HomeScreen2 extends StatelessWidget { // Hot Reload를 사용하지 않으면 위젯 불변의 법칙에 의해 컨테이너의 색이 변경되지 않는다.  
  HomeScreen2({super.key});

  Color color = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                if (color == Colors.blue) {
                  color = Colors.red;
                } else {
                  color = Colors.blue;
                }
                print("색상 변경! color: $color");
              },
              child: Text('색상 변경!'),
            ),
            SizedBox(height: 32,),
            Container(
              width: 50,
              height: 50,
              color: color,
            )
          ],
        ),
      ),
    );
  }
}
