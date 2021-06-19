import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utils/constants.dart';

import '../../common/my_button.dart';
import '../../common/my_textfield.dart';

class TransactionScreen extends StatefulWidget {
  //const TransactionRoute({Key? key}) : super(key: key);

  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DateTime selectedDate = DateTime.now();

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
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _descriptionController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.titleTransaction),
        ),
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(DateFormat.yMMMMd().format(selectedDate)),
                SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  onPressed: () => (_selectDate(context)),
                  child: Text('Select date'),
                )
              ],
            ),
            MyTextField(
              controller: _descriptionController,
              hintText: 'Description',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MyButton(
                  label: 'Cancel',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                MyButton(
                  label: 'Save',
                  onPressed: () {
                    print(_descriptionController.text);
                  },
                ),
              ],
            )
          ],
        ));
  }
}
