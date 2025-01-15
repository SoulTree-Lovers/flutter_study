import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:section30_dust/model/stat_model.dart';
import 'package:section30_dust/utils/status_utils.dart';


class CategoryStat extends StatelessWidget {
  final Region region;
  final Color darkColor;
  final Color lightColor;

  const CategoryStat({
    super.key,
    required this.region,
    required this.darkColor,
    required this.lightColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 160,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: LayoutBuilder(builder: (context, constraint) {
            return Column(
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
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '종류별 통계',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: darkColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: ItemCode.values
                          .map(
                            (itemCode) => FutureBuilder(
                                future: GetIt.I<Isar>()
                                    .statModels
                                    .filter()
                                    .regionEqualTo(region)
                                    .itemCodeEqualTo(itemCode)
                                    .sortByDateTimeDesc()
                                    .findFirst(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasError) {
                                    return Text(
                                      snapshot.error.toString(),
                                    );
                                  }

                                  if (!snapshot.hasData) {
                                    return Container();
                                  }

                                  final statModel = snapshot.data!;
                                  final statusModel =
                                      StatusUtils.getStatusModelFromStat(
                                          stat: statModel);

                                  return SizedBox(
                                    width: constraint.maxWidth / 5,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(itemCode.krName),
                                        SizedBox(height: 8),
                                        Image.asset(
                                          statusModel.imagePath,
                                          width: 50,
                                        ),
                                        SizedBox(height: 8),
                                        Text(
                                          statModel.stat.toString(),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
