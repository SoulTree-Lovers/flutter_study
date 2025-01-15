import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:section30_dust/component/category_stat.dart';
import 'package:section30_dust/component/hourly_stat.dart';
import 'package:section30_dust/component/main_stat.dart';
import 'package:section30_dust/const/color.dart';
import 'package:section30_dust/model/stat_model.dart';

import '../repository/stat_repository.dart';
import '../utils/status_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isExpanded = true;
  Region region = Region.seoul;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    StatRepository.fetchData();
    print(getCount());
    scrollController.addListener(() {
      bool isExpanded = scrollController.offset < (500 - kToolbarHeight);

      if (isExpanded != this.isExpanded) {
        setState(() {
          this.isExpanded = isExpanded;
        });
      }
    });
  }

  getCount() async {
    print(await GetIt.I<Isar>().statModels.count());
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<StatModel?>(
        future: GetIt.I<Isar>()
            .statModels
            .filter()
            .regionEqualTo(region)
            .itemCodeEqualTo(ItemCode.PM10)
            .sortByDateTimeDesc()
            .findFirst(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          final statModel = snapshot.data!;
          final statusModel =
              StatusUtils.getStatusModelFromStat(stat: statModel);

          return Scaffold(
            drawer: Drawer(
              backgroundColor: statusModel.darkColor,
              child: ListView(
                children: [
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    child: Text(
                      '지역 선택',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ...Region.values
                      .map(
                        (r) => ListTile(
                          selected: r == region,
                          tileColor: Colors.white,
                          selectedTileColor: statusModel.lightColor,
                          selectedColor: Colors.black,
                          onTap: () {
                            setState(() {
                              region = r;
                            });
                            Navigator.of(context).pop();
                          },
                          title: Text(r.krName),
                        ),
                      )
                      .toList(),
                ],
              ),
            ),
            backgroundColor: statusModel.primaryColor,
            body: CustomScrollView(
              controller: scrollController,
              slivers: [
                MainStat(
                  region: region,
                  primaryColor: statusModel.primaryColor,
                  isExpanded: isExpanded,
                ),

                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CategoryStat(
                        region: region,
                        darkColor: statusModel.darkColor,
                        lightColor: statusModel.lightColor,
                      ),
                      HourlyStat(
                        region: region,
                        darkColor: statusModel.darkColor,
                        lightColor: statusModel.lightColor,
                      ),
                    ],
                  ),
                ),


              ],
            ),
          );
        });
  }
}
