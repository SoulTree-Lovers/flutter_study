import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:section28_calendar_scheduler/component/calendar.dart';
import 'package:section28_calendar_scheduler/component/center_banner.dart';
import 'package:section28_calendar_scheduler/component/custom_text_field.dart';
import 'package:section28_calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:section28_calendar_scheduler/component/schedule_card.dart';
import 'package:section28_calendar_scheduler/const/color.dart';
import 'package:section28_calendar_scheduler/database/drift.dart';
import 'package:section28_calendar_scheduler/model/schedule.dart';
import 'package:section28_calendar_scheduler/model/schedule_with_category.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.now().toUtc();

  Map<DateTime, List<ScheduleTable>> schedules = {
    // DateTime.utc(2025, 01, 13): [
    //   ScheduleTable(
    //     id: 1,
    //     startTime: 11,
    //     endTime: 12,
    //     content: '플러터 공부하기',
    //     date: DateTime.utc(2025, 01, 13),
    //     color: categoryColors[0],
    //     createdAt: DateTime.now().toUtc(),
    //   ),
    //   ScheduleTable(
    //     id: 1,
    //     startTime: 13,
    //     endTime: 15,
    //     content: 'Spring 공부하기',
    //     date: DateTime.utc(2025, 01, 13),
    //     color: categoryColors[1],
    //     createdAt: DateTime.now().toUtc(),
    //   ),
    // ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet<ScheduleTable>(
            context: context,
            builder: (_) {
              return ScheduleBottomSheet(
                selectedDay: selectedDay,
              );
            },
          );
        },
        backgroundColor: primaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              focusedDay: DateTime.now(),
              onDaySelected: onDaySelected,
              selectedDayPredicate: selectedDayPredicate,
            ),
            StreamBuilder<List<ScheduleWithCategory>>(
              stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
              builder: (context, snapshot) {
                return CenterBanner(
                  selectedDay: selectedDay,
                  taskCount: snapshot.hasData ? snapshot.data!.length : 0,
                );
              }
            ),
            Expanded(
              child: StreamBuilder<List<ScheduleWithCategory>>(
                stream: GetIt.I<AppDatabase>().streamSchedules(selectedDay),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }

                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final schedules = snapshot.data!;

                  return ListView.separated(
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider(
                        color: Colors.grey,
                      );
                    },
                    itemCount: schedules.length,
                    itemBuilder: (BuildContext context, int index) {
                      final scheduleWithCategory = schedules[index];
                      final schedule = scheduleWithCategory.schedule;
                      final category = scheduleWithCategory.category;

                      return Dismissible(
                        key: ObjectKey(schedule.id),
                        direction: DismissDirection.horizontal,
                        // confirmDismiss: (DismissDirection direction) async {
                        //   await GetIt.I<AppDatabase>()
                        //       .deleteSchedule(schedule.id);
                        //   return true;
                        // },
                        onDismissed: (DismissDirection direction) {
                          // StreamBuilder에서는 onDismissed를 사용할 수 있음.
                          GetIt.I<AppDatabase>().deleteSchedule(schedule.id);
                        },
                        child: GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet<ScheduleTable>(
                              context: context,
                              builder: (_) {
                                return ScheduleBottomSheet(
                                  id: schedule.id,
                                  selectedDay: selectedDay,
                                );
                              },
                            );
                          },
                          child: ScheduleCard(
                            startTime: schedule.startTime,
                            endTime: schedule.endTime,
                            content: schedule.content,
                            color: Color(
                              int.parse(category.color, radix: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    print("selectedDay $selectedDay");
    print("focusedDay $focusedDay");
    setState(() {
      this.selectedDay = selectedDay;
    });
  }

  bool selectedDayPredicate(DateTime date) {
    if (selectedDay == null) {
      return false;
    }
    // return isSameDay(date, DateTime.now());
    return date.isAtSameMomentAs(selectedDay!);
  }
}
