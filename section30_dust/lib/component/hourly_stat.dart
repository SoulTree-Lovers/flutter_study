import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:section30_dust/model/stat_model.dart';
import 'package:section30_dust/utils/status_utils.dart';

class HourlyStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;

  const HourlyStat({
    super.key,
    required this.region,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: ItemCode.values
          .map(
            (itemCode) => FutureBuilder<List<StatModel>>(
                future: GetIt.I<Isar>()
                    .statModels
                    .filter()
                    .regionEqualTo(region)
                    .itemCodeEqualTo(itemCode)
                    .sortByDateTimeDesc()
                    .limit(10)
                    .findAll(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        snapshot.error.toString(),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final stats = snapshot.data!;

                  return SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Card(
                        color: darkColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: lightColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  '시간별 ${itemCode.krName}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                            ...stats.map(
                              (stat) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                            '${stat.dateTime.hour.toString().padLeft(2, '0')}시')),
                                    Expanded(
                                      child: Image.asset(
                                        StatusUtils.getStatusModelFromStat(
                                                stat: stat)
                                            .imagePath,
                                        height: 20,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        StatusUtils.getStatusModelFromStat(
                                                stat: stat)
                                            .label,
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          )
          .toList(),
    );
  }
}
