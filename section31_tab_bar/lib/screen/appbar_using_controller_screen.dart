import 'package:flutter/material.dart';
import 'package:section31_tab_bar/const/tabs.dart';

class AppbarUsingControllerScreen extends StatefulWidget {
  const AppbarUsingControllerScreen({super.key});

  @override
  State<AppbarUsingControllerScreen> createState() => _AppbarUsingControllerScreenState();
}

class _AppbarUsingControllerScreenState extends State<AppbarUsingControllerScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    tabController = TabController(
      length: TABS.length,
      vsync: this,
    );

    tabController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar Controller Screen'),
        bottom: TabBar(
          controller: tabController,
          tabs: TABS
              .map(
                (tab) => Tab(
                  icon: Icon(tab.icon),
                  child: Text(tab.label),
                ),
              )
              .toList(),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: TABS
            .map(
              (tab) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(tab.icon),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          tabController.animateTo(
                            tabController.index - 1 < 0
                                ? TABS.length - 1
                                : tabController.index - 1,
                          );
                        },
                        child: Text('이전'),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () {
                          tabController.animateTo(
                            tabController.index + 1 >= TABS.length
                                ? 0
                                : tabController.index + 1,
                          );
                        },
                        child: Text('다음'),
                      ),
                    ],
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
