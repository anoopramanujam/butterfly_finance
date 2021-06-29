import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:butterfly_finance/notifiers/transaction_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

import '../../common/my_button.dart';
import '../../common/my_textfield.dart';
import '../../common/my_date_picker.dart';

/// Add and Edit transactions
class TransactionAddEdit extends StatefulWidget {
  const TransactionAddEdit({Key? key, required this.transaction})
      : super(key: key);

  final TransactionModel transaction;
  @override
  _TransactionAddEditState createState() => _TransactionAddEditState();
}

class _TransactionAddEditState extends State<TransactionAddEdit> {
  // transaction columns
  late int _txnId;
  late DateTime _txnDate;
  late String _txnDescription;
  late double _txnAmount;

  // textbox controllers
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;

  @override
  void initState() {
    super.initState();
    _txnId = widget.transaction.txnId;
    _txnDate = widget.transaction.txnDate;
    _txnDescription = widget.transaction.description;
    _txnAmount = widget.transaction.amount;
    _descriptionController = TextEditingController(text: _txnDescription);

    // show empty Amount textbox if zero
    _amountController = TextEditingController(
        text: _txnAmount == 0.0
            ? ''
            : _txnAmount.toStringAsFixed(Constants.decimalPlaces));
  }

  /// User has changed date
  _changeDate(changedDate) {
    setState(() {
      _txnDate = changedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constants.paddingWidth, vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  height: Constants.dividerHeight,
                ),
                // Date information
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
                // Amount field
                MyTextField(
                  controller: _amountController,
                  hintText: Constants.labelTxnAmount,
                  isNumeric: true,
                ),
                // Description field
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
                      onPressed: () async {
                        double amount =
                            double.tryParse(_amountController.text) ??
                                Constants.invalidAmount;
                        // Error if not a valid amount
                        if (amount == Constants.invalidAmount) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: const Text(Constants.errInvalidAmount),
                            backgroundColor: Constants.colorErrorMessage,
                          ));
                          return;
                        }
                        final transaction = TransactionModel(
                            txnDate: _txnDate,
                            amount: amount,
                            description: _descriptionController.text);

                        if (_txnId == Constants.indexNewRecord) {
                          context.read<TransactionNotifier>().add(transaction);
                        } else {
                          context
                              .read<TransactionNotifier>()
                              .update(transaction, _txnId);
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            )));
  }
}
