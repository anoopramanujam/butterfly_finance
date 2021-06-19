import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../utils/constants.dart';

import '../../common/my_button.dart';
import '../../common/my_textfield.dart';
import '../../common/my_date_picker.dart';

class TransactionScreen extends StatefulWidget {
  //final _txnDate = DateTime.now();
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  DateTime _txnDate = DateTime.now();

  _changeDate(changedDate) {
    setState(() {
      _txnDate = changedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _descriptionController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.titleTransaction),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: Constants.dividerHeight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Transaction Date'),
                  Text(DateFormat.yMMMMd().format(_txnDate)),
                  MyDatePicker(
                    onDateChange: (selectedDate) {
                      //_txnDate = selectedDate;
                      //print('Selected ' + selectedDate.toString());
                      _changeDate(selectedDate);
                    },
                  )
                ],
              ),
              SizedBox(
                height: Constants.dividerHeight,
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
                      print(_descriptionController.text +
                          ' on ' +
                          _txnDate.toString());
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
