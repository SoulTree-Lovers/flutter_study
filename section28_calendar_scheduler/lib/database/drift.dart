import 'dart:io';

import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:section28_calendar_scheduler/model/schedule_with_category.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:sqlite3/sqlite3.dart';
import '../model/category.dart';
import '../model/schedule.dart';

part 'drift.g.dart';

@DriftDatabase(tables: [
  ScheduleTable,
  CategoryTable,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  Future<int> createCategory(CategoryTableCompanion data) =>
      into(categoryTable).insert(data);

  Future<List<CategoryTableData>> getCategories() => select(categoryTable).get();

  Future<ScheduleWithCategory> getScheduleById(int id) {
    final query = select(scheduleTable).join([
      innerJoin(
          categoryTable, categoryTable.id.equalsExp(scheduleTable.categoryId)),
    ])
      ..where(scheduleTable.id.equals(id))
      ..orderBy([
        OrderingTerm(expression: scheduleTable.startTime, mode: OrderingMode.asc),
        OrderingTerm(expression: scheduleTable.endTime, mode: OrderingMode.asc),
      ]);

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(
        category: category,
        schedule: schedule,
      );
    }).getSingle();
  }


  Future<int> updateScheduleById(int id, ScheduleTableCompanion data) =>
      (update(scheduleTable)..where((table) => table.id.equals(id)))
          .write(data);

  Future<List<ScheduleTableData>> getSchedules(DateTime date) {
    return (select(scheduleTable)..where((table) => table.date.equals(date)))
        .get();

    /// 위 코드를 아래와 같이 변경해도 무방함
    final selectQuery = select(scheduleTable);
    selectQuery.where((table) => table.date.equals(date));
    return selectQuery.get();
  }

  Stream<List<ScheduleWithCategory>> streamSchedules(DateTime date) {
    final query = select(scheduleTable).join([
      innerJoin(
          categoryTable, categoryTable.id.equalsExp(scheduleTable.categoryId)),
    ])
      ..where(scheduleTable.date.equals(date))
      ..orderBy([
        OrderingTerm(expression: scheduleTable.startTime, mode: OrderingMode.asc),
        OrderingTerm(expression: scheduleTable.endTime, mode: OrderingMode.asc),
      ]);

    return query.map((row) {
      final schedule = row.readTable(scheduleTable);
      final category = row.readTable(categoryTable);

      return ScheduleWithCategory(
        category: category,
        schedule: schedule,
      );
    }).watch();
  }

  Future<int> createSchedule(ScheduleTableCompanion data) =>
      into(scheduleTable).insert(data);

  Future<int> deleteSchedule(int id) =>
      (delete(scheduleTable)..where((table) => table.id.equals(id))).go();

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.addColumn(categoryTable, categoryTable.randomNumber as GeneratedColumn<Object>);
        }

        if (from < 3) {
          await m.addColumn(categoryTable, categoryTable.randomNumber2 as GeneratedColumn<Object>);
        }
      },
    );
  }
}

LazyDatabase _openConnection() {
  /// 데이터베이스 파일을 생성하고 반환 (그냥 이대로 사용하면 됨)
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(
      p.join(dbFolder.path, 'db.sqlite'),
    ); // dart.io에서 불러와야 함.

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions(); // 안드로이드 예전 버전에서 생기는 버그 해결
    }

    final cachebase = await getTemporaryDirectory();

    sqlite3.tempDirectory = cachebase.path;

    return NativeDatabase.createInBackground(file);
  });
}
