import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';

import '../../common/my_toggle_button.dart';
import '../../common/my_dropdown.dart';

class AccountDropdowns extends StatefulWidget {
  const AccountDropdowns({
    Key? key,
    required this.transaction,
    required this.selectedTxnType,
    required this.accounts,
    required this.selectedFromAccount,
    required this.selectedToAccount,
    required this.onAccountsChange,
  }) : super(key: key);

  final TransactionModel transaction;
  final List<Map> accounts;
  final String selectedTxnType;
  final int selectedFromAccount;
  final int selectedToAccount;
  final Function onAccountsChange;

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
      };
    }).toList();
    _fromAccounts = getAccounts(_selectedTxnType, true);
    _toAccounts = getAccounts(_selectedTxnType, false);

    _fromAccountValue = widget.selectedFromAccount == Constants.indexNewRecord
        ? setDefaultAccount(true)
        : widget.selectedFromAccount.toString();
    _toAccountValue = widget.selectedToAccount == Constants.indexNewRecord
        ? setDefaultAccount(false)
        : widget.selectedToAccount.toString();
  }

  String setDefaultAccount(bool isFromAccount) {
    String defaultAccount = '';
    if (isFromAccount) {
      defaultAccount = _fromAccounts[0]['value'].toString();
      widget.onAccountsChange(fromAccount: defaultAccount);
    } else {
      defaultAccount = _toAccounts[0]['value'].toString();
      widget.onAccountsChange(toAccount: defaultAccount);
    }
    return defaultAccount;
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
        selectedItem: _selectedTxnType.toString(),
        onPressed: (int selectedValue) {
          setState(() {
            _selectedTxnType = selectedValue;
            _fromAccounts = getAccounts(selectedValue, true);
            _toAccounts = getAccounts(selectedValue, false);
            _fromAccountValue =
                widget.selectedFromAccount == Constants.indexNewRecord
                    ? _fromAccounts[0]['value'].toString()
                    : widget.selectedFromAccount.toString();
            _toAccountValue =
                widget.selectedToAccount == Constants.indexNewRecord
                    ? _toAccounts[0]['value'].toString()
                    : widget.selectedToAccount.toString();
            widget.onAccountsChange(
                txnType: selectedValue,
                fromAccount: _fromAccountValue,
                toAccount: _toAccountValue);
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('From Account'),
          MyDropDown(
            dropdownItems: _fromAccounts,
            selectedValue: _fromAccountValue,
            onChanged: (val) {
              _fromAccountValue = val;
              widget.onAccountsChange(fromAccount: val);
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
            selectedValue: _toAccountValue,
            onChanged: (val) {
              _toAccountValue = val;
              widget.onAccountsChange(toAccount: val);
            },
          ),
        ],
      ),
    ]);
  }
}
