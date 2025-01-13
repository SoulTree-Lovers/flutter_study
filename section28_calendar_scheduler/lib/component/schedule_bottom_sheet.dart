import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:section28_calendar_scheduler/database/drift.dart';
import 'package:section28_calendar_scheduler/model/schedule.dart';

import '../const/color.dart';
import 'custom_text_field.dart';

class ScheduleBottomSheet extends StatefulWidget {
  final int? id;
  final DateTime selectedDay;

  const ScheduleBottomSheet({
    super.key,
    this.id,
    required this.selectedDay,
  });

  @override
  State<ScheduleBottomSheet> createState() => _ScheduleBottomSheetState();
}

class _ScheduleBottomSheetState extends State<ScheduleBottomSheet> {
  final GlobalKey<FormState> formKey = GlobalKey();

  int? startTime;
  int? endTime;
  String? content;
  String selectedCategory = categoryColors[0];
  int? selectedCategoryId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initCategory();
  }

  initCategory() async {
    if (widget.id != null) {
      final response = await GetIt.I<AppDatabase>().getScheduleById(widget.id!);

      setState(() {
        selectedCategoryId = response.category.id;
      });
    } else {
      final response = await GetIt.I<AppDatabase>().getCategories();

      setState(() {
        selectedCategoryId = response.first.id;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (selectedCategoryId == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return FutureBuilder(
        future: widget.id == null
            ? null
            : GetIt.I<AppDatabase>().getScheduleById(widget.id!),
        builder: (context, snapshot) {
          if (widget.id != null &&
              snapshot.connectionState == ConnectionState.waiting &&
              !snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data?.schedule;

          return Container(
            color: Colors.white,
            height: 600,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      _Time(
                        onStartSaved: onStartTimeSaved,
                        onEndSaved: onEndTimeSaved,
                        onStartValidator: onStartTimeValidated,
                        onEndValidator: onEndTimeValidated,
                        startTimeInitialValue: data?.startTime.toString(),
                        endTimeInitialValue: data?.endTime.toString(),
                      ),
                      SizedBox(height: 8),
                      _Content(
                        onSaved: onContentSaved,
                        onValidated: onContentValidated,
                        initialValue: data?.content,
                      ),
                      SizedBox(height: 8),
                      _Categories(
                        selectedCategoryId: selectedCategoryId!,
                        onTap: (int categoryId) {
                          setState(() {
                            selectedCategoryId = categoryId;
                            print(
                                'selectedCategoryColor: ${colorToName[categoryId]}');
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      _SaveButton(
                        onPressed: onSavePressed,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  void onStartTimeSaved(String? value) {
    if (value == null) {
      return;
    }
    startTime = int.parse(value);
  }

  String? onStartTimeValidated(String? value) {
    if (value == null) {
      return '시작 시간을 입력해주세요.';
    }

    if (int.tryParse(value) == null) {
      return '숫자만 입력해주세요.';
    }

    final time = int.parse(value);

    if (time > 24 || time < 0) {
      return '0~24 사이의 숫자를 입력해주세요.';
    }

    return null;
  }

  void onEndTimeSaved(String? value) {
    if (value == null) {
      return;
    }
    endTime = int.parse(value);
  }

  String? onEndTimeValidated(String? value) {
    if (value == null) {
      return '시작 시간을 입력해주세요.';
    }

    if (int.tryParse(value) == null) {
      return '숫자만 입력해주세요.';
    }

    final time = int.parse(value);

    if (time > 24 || time < 0) {
      return '0~24 사이의 숫자를 입력해주세요.';
    }

    return null;
  }

  void onContentSaved(String? value) {
    if (value == null) {
      return;
    }
    content = value;
  }

  String? onContentValidated(String? value) {
    if (value == null) {
      return '내용을 입력해주세요.';
    }

    if (value.length > 100) {
      return '100자 이내로 입력해주세요.';
    }

    return null;
  }

  void onSavePressed() async {
    final bool isValid = formKey.currentState!.validate();

    if (isValid == false) {
      return;
    }

    formKey.currentState!.save();

    final database = GetIt.I<AppDatabase>(); // DI

    if (widget.id == null) {
      await database.createSchedule(ScheduleTableCompanion(
        startTime: Value(startTime!),
        endTime: Value(endTime!),
        content: Value(content!),
        date: Value(widget.selectedDay),
        categoryId: Value(selectedCategoryId!),
      ));
    } else {
      await database.updateScheduleById(
        widget.id!,
        ScheduleTableCompanion(
          startTime: Value(startTime!),
          endTime: Value(endTime!),
          content: Value(content!),
          date: Value(widget.selectedDay),
          categoryId: Value(selectedCategoryId!),
        ),
      );
    }

    Navigator.of(context).pop();
  }
}

class _Time extends StatelessWidget {
  final FormFieldSetter<String> onStartSaved;
  final FormFieldSetter<String> onEndSaved;
  final FormFieldValidator<String> onStartValidator;
  final FormFieldValidator<String> onEndValidator;
  final String? startTimeInitialValue;
  final String? endTimeInitialValue;

  const _Time({
    super.key,
    required this.onStartSaved,
    required this.onEndSaved,
    required this.onStartValidator,
    required this.onEndValidator,
    this.startTimeInitialValue,
    this.endTimeInitialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: '시작 시간',
                onSaved: onStartSaved,
                validator: onStartValidator,
                initialValue: startTimeInitialValue,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                label: '마감 시간',
                onSaved: onEndSaved,
                validator: onEndValidator,
                initialValue: endTimeInitialValue,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Content extends StatelessWidget {
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> onValidated;
  final String? initialValue;

  const _Content({
    super.key,
    required this.onSaved,
    required this.onValidated,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomTextField(
        label: '내용',
        expand: true,
        onSaved: onSaved,
        validator: onValidated,
        initialValue: initialValue,
      ),
    );
  }
}

typedef OnColorSelected = void Function(int categoryId);

class _Categories extends StatelessWidget {
  final int selectedCategoryId;
  final OnColorSelected onTap;

  const _Categories({
    super.key,
    required this.selectedCategoryId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: GetIt.I<AppDatabase>().getCategories(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        return Row(
          children: snapshot.data!
              .map(
                (category) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      onTap(category.id);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(
                          int.parse(
                            category.color,
                            radix: 16,
                          ),
                        ),
                        border: Border.all(
                          color: Colors.black,
                          width: selectedCategoryId == category.id ? 2.0 : 0.0,
                        ),
                        shape: BoxShape.circle,
                      ),
                      width: 32.0,
                      height: 32.0,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      }
    );
  }
}

class _SaveButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _SaveButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
            ),
            child: Text('저장'),
          ),
        ),
      ],
    );
  }
}
