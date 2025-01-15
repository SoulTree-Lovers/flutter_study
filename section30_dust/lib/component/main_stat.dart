import 'package:flutter/material.dart' hide DateUtils;
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:section30_dust/const/status_level.dart';
import 'package:section30_dust/model/stat_model.dart';
import 'package:section30_dust/utils/date_utils.dart';
import 'package:section30_dust/utils/status_utils.dart';

class MainStat extends StatelessWidget {
  final Region region;
  final Color primaryColor;
  final bool isExpanded;

  const MainStat({
    super.key,
    required this.region,
    required this.primaryColor,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontWeight: FontWeight.w700,
    );

    return SliverAppBar(
      backgroundColor: primaryColor,
      expandedHeight: 500,
      title: isExpanded ? null : Text('${region.krName}'),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: SizedBox(
            width: double.infinity,
            child: FutureBuilder<StatModel?>(
              future: GetIt.I<Isar>()
                  .statModels
                  .filter()
                  .regionEqualTo(Region.seoul)
                  .itemCodeEqualTo(ItemCode.PM10)
                  .sortByDateTimeDesc()
                  .findFirst(),
              builder: (context, snapshot) {
                if (!snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (!snapshot.hasData) {
                  return Center(
                    child: Text('데이터가 없습니다.'),
                  );
                }

                final statModel = snapshot.data!;

                final status =
                    StatusUtils.getStatusModelFromStat(stat: statModel);

                return Column(
                  children: [
                    SizedBox(height: kToolbarHeight),
                    Text(
                      region.krName,
                      style: textStyle,
                    ),
                    Text(
                        DateUtils.DateTimeToString(
                            dateTime: statModel.dateTime),
                        style: textStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    SizedBox(height: 20),
                    Image.asset(
                      status.imagePath,
                      width: MediaQuery.of(context).size.width / 2,
                    ),
                    SizedBox(height: 20),
                    Text(
                      status.label,
                      style: textStyle.copyWith(
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      status.comment,
                      style: textStyle.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
