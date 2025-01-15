import 'package:section30_dust/const/status_level.dart';
import 'package:section30_dust/model/status_model.dart';

import '../model/stat_model.dart';

class StatusUtils {
  static StatusModel getStatusModelFromStat({
    required StatModel stat,
  }) {
    final itemCode = stat.itemCode;

    final index = statusLevels.indexWhere((e) {
      switch (itemCode) {
        case ItemCode.PM10:
          return stat.stat < e.minPM10;
        case ItemCode.PM25:
          return stat.stat < e.minPM25;
        case ItemCode.O3:
          return stat.stat < e.minO3;
        case ItemCode.NO2:
          return stat.stat < e.minNO2;
        case ItemCode.CO:
          return stat.stat < e.minCO;
        case ItemCode.SO2:
          return stat.stat < e.minSO2;
        default:
          throw Exception('존재하지 않는 item code입니다.');
      }
    });

    if (index < 0) {
      throw Exception('통계 수치 에러 발생');
    }

    return statusLevels[index - 1];
  }
}
