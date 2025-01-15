import 'package:isar/isar.dart';
part 'stat_model.g.dart';

enum Region {
  seoul,
  busan,
  daegu,
  incheon,
  gwangju,
  daejeon,
  ulsan,
  sejong,
  gyeonggi,
  gangwon,
  chungbuk,
  chungnam,
  jeonbuk,
  jeonnam,
  gyeongbuk,
  gyeongnam,
  jeju;

  String get krName {
    switch (this) {
      case Region.seoul:
        return '서울';
      case Region.busan:
        return '부산';
      case Region.daegu:
        return '대구';
      case Region.incheon:
        return '인천';
      case Region.gwangju:
        return '광주';
      case Region.daejeon:
        return '대전';
      case Region.ulsan:
        return '울산';
      case Region.sejong:
        return '세종';
      case Region.gyeonggi:
        return '경기';
      case Region.gangwon:
        return '강원';
      case Region.chungbuk:
        return '충북';
      case Region.chungnam:
        return '충남';
      case Region.jeonbuk:
        return '전북';
      case Region.jeonnam:
        return '전남';
      case Region.gyeongbuk:
        return '경북';
      case Region.gyeongnam:
        return '경남';
      case Region.jeju:
        return '제주';
      default:
        throw Exception('알 수 없는 지역');
    }
  }
}

enum ItemCode {
  SO2,
  CO,
  O3,
  NO2,
  PM10,
  PM25;

  String get krName {
    switch (this) {
      case ItemCode.SO2:
        return '아황산가스';
      case ItemCode.CO:
        return '일산화탄소';
      case ItemCode.O3:
        return '오존';
      case ItemCode.NO2:
        return '이산화질소';
      case ItemCode.PM10:
        return '미세먼지';
      case ItemCode.PM25:
        return '초미세먼지';
      default:
        throw Exception('알 수 없는 항목');
    }
  }
}

@collection
class StatModel {
  Id id = Isar.autoIncrement;

  @enumerated
  @Index(unique: true, composite: [
    CompositeIndex('dateTime'),
    CompositeIndex('itemCode'),
  ]) // region, dateTime, itemCode 3개의 조합이 중복되는 데이터가 없도록 설정
  late Region region; // 지역

  late double stat; // 미세먼지 지수

  late DateTime dateTime; // 날짜

  @enumerated
  late ItemCode itemCode; // 미세먼지 항목 코드

}