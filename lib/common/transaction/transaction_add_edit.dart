import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:butterfly_finance/notifiers/transaction_notifier.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

import '../../common/my_button.dart';
import '../../common/my_textfield.dart';
import '../../common/my_date_picker.dart';
import '../../common/my_toggle_button.dart';
import '../../common/my_dropdown.dart';
import '../../models/account_model.dart';
import '../../notifiers/account_notifier.dart';

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

  late int _selectedTxnType;

  Future<List<AccountModel>>? _accounts;

  // textbox controllers
  late TextEditingController _descriptionController;
  late TextEditingController _amountController;

  // String? dropdownValue;

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

    _selectedTxnType = widget.transaction.type;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final accountNotifier = Provider.of<AccountNotifier>(context);
    _accounts = accountNotifier.getAllAccounts();
    // dropdownValue = '';
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

                SizedBox(
                  height: Constants.dividerHeight,
                ),

                FutureBuilder<List<AccountModel>>(
                    future: _accounts,
                    builder: (BuildContext context,
                        AsyncSnapshot<List<AccountModel>> snapshot) {
                      if (snapshot.hasData) {
                        final realAccounts = snapshot.data ?? [];

                        List<Map> listAccounts = [];

                        for (int i = 0; i < realAccounts.length; i++) {
                          var _account = realAccounts[i];

                          listAccounts.add({
                            'title': _account.name,
                            'value': _account.accountId,
                            'isSelected': (i == 0) ? true : false,
                            'type': _account.type,
                          });
                        }

                        return AccountDropdowns(
                          accounts: listAccounts,
                          transaction: widget.transaction,
                        );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),

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
                          description: _descriptionController.text,
                          // type: _selectedTxnType,
                        );

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

class AccountDropdowns extends StatefulWidget {
  const AccountDropdowns({
    Key? key,
    required this.transaction,
    required this.accounts,
  }) : super(key: key);

  final TransactionModel transaction;
  final List<Map> accounts;

  @override
  _AccountDropdownsState createState() => _AccountDropdownsState();
}

class _AccountDropdownsState extends State<AccountDropdowns> {
  late int _selectedTxnType;
  late String _fromAccountValue;
  late String _toAccountValue;
  late List<Map> _toggleItems;

  late List<Map> _fromAccounts;
  late List<Map> _toAccounts;

  @override
  void initState() {
    super.initState();
    _selectedTxnType = widget.transaction.type;
    const txnTypes = [
      Constants.txnIncome,
      Constants.txnTransfer,
      Constants.txnExpense,
    ];
    _toggleItems = txnTypes.map((txnType) {
      return {
        'title': Constants.txnTypeLabels[txnType],
        'value': txnType,
        'isSelected': (widget.transaction.type == txnType) ? true : false
      };
    }).toList();
    _fromAccounts = getAccounts(_selectedTxnType, true);
    _toAccounts = getAccounts(_selectedTxnType, false);

    _fromAccountValue = _fromAccounts
        .where((element) => element['isSelected'] == true)
        .first['value'];
    _toAccountValue = _toAccounts
        .where((element) => element['isSelected'] == true)
        .first['value'];
  }

  List<Map> getAccounts(int selectedTxnType, bool fromAccount) {
    List<Map> returnAccounts = [];
    List<int> accountTypes = [];
    switch (selectedTxnType) {
      case Constants.txnIncome:
        accountTypes = fromAccount
            ? [Constants.accountIncome]
            : [Constants.accountAsset, Constants.accountLiability];
        break;
      case Constants.txnTransfer:
        accountTypes = [Constants.accountAsset, Constants.accountLiability];
        break;
      case Constants.txnExpense:
        accountTypes = fromAccount
            ? [Constants.accountAsset, Constants.accountLiability]
            : [Constants.accountExpense];
        break;
    }
    widget.accounts.forEach((element) {
      if (accountTypes.contains(element['type'])) {
        if (returnAccounts.length == 0) {
          element['isSelected'] = true;
        } else {
          element['isSelected'] = false;
        }
        returnAccounts.add(element);
      }
    });
    return returnAccounts;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MyToggleButton(
        toggleItems: _toggleItems,
        onPressed: (int selectedValue) {
          setState(() {
            _selectedTxnType = selectedValue;
            _fromAccounts = getAccounts(selectedValue, true);
            _toAccounts = getAccounts(_selectedTxnType, false);
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('From Account'),
          MyDropDown(
            dropdownItems: _fromAccounts,
            onChanged: (val) {
              _fromAccountValue = val;
            },
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('To Account'),
          MyDropDown(
            dropdownItems: _toAccounts,
            onChanged: (val) {
              _toAccountValue = val;
            },
          ),
        ],
      ),
    ]);
  }
}
