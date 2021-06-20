import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:butterfly_finance/notifiers/transaction_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

import '../../common/my_button.dart';
import '../../common/my_textfield.dart';
import '../../common/my_date_picker.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({Key? key, this.txnId = Constants.indexNewRecord})
      : super(key: key);

  final txnId;

  //final _txnDate = DateTime.now();
  @override
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late DateTime _txnDate;
  late String _txnDescription;
  late double _txnAmount = 0.0;

  late TextEditingController _descriptionController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    if (widget.txnId != Constants.indexNewRecord) {
      TransactionNotifier txnNotifier = context.read<TransactionNotifier>();
      TransactionModel txnDefault = txnNotifier.getTransaction(widget.txnId);
      _txnDescription = txnDefault.description;
      _txnDate = txnDefault.txnDate;
      _txnAmount = txnDefault.amount;
    } else {
      _txnDate = DateTime.now();
      _txnDescription = '';
      _txnAmount = 0.0;
    }
    _descriptionController = TextEditingController(text: _txnDescription);
    _amountController = TextEditingController(
        text: _txnAmount == 0.0
            ? ''
            : _txnAmount.toStringAsFixed(Constants.decimalPlaces));
  }

  _changeDate(changedDate) {
    setState(() {
      _txnDate = changedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Constants.titleTransaction),
        ),
        body: SingleChildScrollView(
          child: Padding(
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
                        double amount = double.parse(_amountController.text);
                        assert(amount is double);
                        final transaction = TransactionModel(
                            txnDate: _txnDate,
                            amount: amount,
                            description: _descriptionController.text);

                        if (widget.txnId == Constants.indexNewRecord) {
                          context.read<TransactionNotifier>().add(transaction);
                        } else {
                          context
                              .read<TransactionNotifier>()
                              .update(transaction, widget.txnId);
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
