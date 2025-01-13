import 'package:flutter/material.dart';
import 'package:section28_calendar_scheduler/const/color.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool expand;
  final FormFieldSetter<String> onSaved;
  final FormFieldValidator<String> validator;
  final String? initialValue;

  const CustomTextField({
    super.key,
    required this.label,
    this.expand = false,
    required this.onSaved,
    required this.validator,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!expand) renderTextFormField(),
        if (expand) Expanded(child: renderTextFormField()),
      ],
    );
  }

  renderTextFormField() {
    return TextFormField(
      decoration: InputDecoration(
        border: InputBorder.none,
        fillColor: Colors.grey[300],
        filled: true,
        labelText: '입력',
      ),
      onSaved: onSaved, // 저장 시 호출할 함수
      validator: validator, // 유효성 검사 함수
      maxLines: expand ? null : 1,
      minLines: expand ? null : 1,
      expands: expand,
      cursorColor: Colors.grey,
      initialValue: initialValue,
    );
  }
}
