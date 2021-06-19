import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class MyDatePicker extends StatelessWidget {
  MyDatePicker({Key? key, required this.onDateChange});

  final DateTime selectedDate = DateTime.now();
  final Function onDateChange;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2200));
    if (picked == null) {
      return;
    }
    if (picked != selectedDate) {
      onDateChange(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => (_selectDate(context)),
      child: Text(Constants.datePickerLabel),
    );
  }
}
