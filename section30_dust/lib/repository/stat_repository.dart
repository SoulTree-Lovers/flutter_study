import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:section30_dust/model/stat_model.dart';

class StatRepository {
  static Future<void> fetchData() async {
    final isar = GetIt.I<Isar>();

    final now = DateTime.now();

    final compareDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      now.hour,
    );

    final count = await isar.statModels
        .filter()
        .dateTimeEqualTo(compareDateTime)
        .count();

    print('count: $count');
    if (count > 0) {
      print('이미 데이터가 존재합니다: $count');
      return;
    }

    for (ItemCode itemCode in ItemCode.values) {
      await fetchDataByItemCode(itemCode: itemCode);
    }
  }

  static Future<List<StatModel>> fetchDataByItemCode({
    required ItemCode itemCode,
  }) async {
    final response = await Dio().get(
      'http://apis.data.go.kr/B552584/ArpltnStatsSvc/getCtprvnMesureLIst',
      queryParameters: {
        'serviceKey':
            'am5LVYGC/jjEFQAa7orN7GNRTM1bvLROkKHi0/lwSuhXRD1CeOIKU6qO2w54BE+GU/AE9NwyraZCukf5Vu0WOQ==',
        // Dio에서 자동으로 인코딩하기 때문에 디코딩 값을 넣어야 함.
        'returnType': 'json',
        'numOfRows': 100,
        'pageNo': 1,
        'itemCode': itemCode.name,
        'dataGubun': 'HOUR',
        'searchCondition': 'WEEK',
      },
    );

    final rawItemsList = response.data['response']['body']['items'];

    List<StatModel> statList = [];

    final List<String> skipKeys = [
      'dataGubun',
      'dataTime',
      'itemCode',
    ];

    for (Map<String, dynamic> item in rawItemsList) {
      final dateTime = DateTime.parse(item['dataTime']);

      for (String key in item.keys) {
        if (skipKeys.contains(key)) {
          // print("skip key: $key");
          continue;
        }

        final regionString = key;
        final stat = double.parse(item[regionString]);
        final region = Region.values.firstWhere((e) => e.name == regionString);

        final statModel = StatModel()
          ..region = region
          ..stat = stat
          ..dateTime = dateTime
          ..itemCode = itemCode;

        final isar = GetIt.I<Isar>();

        // 중복 데이터 체크 (region, dateTime, itemCode 3개의 조합이 중복되는 데이터가 없도록 설정)
        final count = await isar.statModels
            .filter()
            .regionEqualTo(region)
            .dateTimeEqualTo(dateTime)
            .itemCodeEqualTo(itemCode)
            .count();

        // 중복 데이터가 있으면 다음 데이터로 넘어감
        if (count > 0) {
          // print("중복 데이터 존재");
          continue;
        }

        // 데이터베이스에 저장
        await isar.writeTxn(() async {
          print('저장: $statModel');
          await isar.statModels.put(statModel);
        });

        // print(key);

        // statList = [
        //   ...statList,
        //   StatModel(
        //     region: Region.values.firstWhere(
        //       (e) => e.name == regionString,
        //     ),
        //     stat: double.parse(stat),
        //     dateTime: DateTime.parse(dateTime),
        //     itemCode: itemCode,
        //   )
        // ];
      }
    }

    return statList;
  }
}
