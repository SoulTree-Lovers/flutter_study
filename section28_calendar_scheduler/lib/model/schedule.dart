import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:section28_calendar_scheduler/model/category.dart';

class ScheduleTable extends Table {
  /// 식별 가능한 ID
  IntColumn get id => integer().autoIncrement()();

  /// 시작 시간
  IntColumn get startTime => integer()();

  /// 종료 시간
  IntColumn get endTime => integer()();

  /// 일정 내용
  TextColumn get content => text()();

  /// 날짜
  DateTimeColumn get date => dateTime()();

  /// 카테고리
  IntColumn get categoryId => integer().references(CategoryTable, #id)();

  /// 일정 생성 날짜 시간
  DateTimeColumn get createdAt => dateTime().clientDefault(() => DateTime.now().toUtc())();

}
