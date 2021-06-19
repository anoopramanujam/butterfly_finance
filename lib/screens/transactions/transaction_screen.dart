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
    final _amountController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.titleTransaction),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Constants.paddingWidth, vertical: 0),
          child: Column(
            children: [
              SizedBox(
                height: Constants.dividerHeight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Constants.labelTxnDate),
                  Text(DateFormat.yMMMMd().format(_txnDate)),
                  MyDatePicker(
                    selectedDate: _txnDate,
                    onDateChange: (selectedDate) {
                      _changeDate(selectedDate);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: Constants.dividerHeight,
              ),
              MyTextField(
                controller: _amountController,
                hintText: Constants.labelTxnAmount,
                isNumeric: true,
              ),
              MyTextField(
                controller: _descriptionController,
                hintText: Constants.labelTxnDesc,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyButton(
                    label: Constants.btnCancel,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  MyButton(
                    label: Constants.btnSave,
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
