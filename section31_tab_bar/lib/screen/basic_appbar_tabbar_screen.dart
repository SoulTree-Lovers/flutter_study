import 'package:flutter/material.dart';
import 'package:section31_tab_bar/const/tabs.dart';

class BasicAppbarTabbarScreen extends StatelessWidget {
  const BasicAppbarTabbarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: TABS.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Basic AppBar TabBar Screen'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(100),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text("여기에 다른 위젯 넣을 수 있음"),
                TabBar(
                  indicatorColor: Colors.red,
                  indicatorWeight: 5,
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  labelStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.normal,
                  ),
                  tabs: TABS
                      .map(
                        (tab) => Tab(
                      icon: Icon(tab.icon),
                      child: Text(tab.label),
                    ),
                  )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            ...TABS
                .map(
                  (tab) => Center(
                    child: Text(
                      tab.label,
                    ),
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }
}
