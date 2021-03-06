import 'package:flutter/material.dart';

class Constants {
  static const accountBalance = 0;
  static const accountAsset = 1;
  static const accountLiability = 2;
  static const accountIncome = 3;
  static const accountExpense = 4;

  static const accountLabels = [
    'Balance',
    'Asset',
    'Liability',
    'Income',
    'Expense',
  ];

  static const txnTransfer = 0;
  static const txnIncome = 1;
  static const txnExpense = 2;

  static const txnTypeLabels = [
    'Transfer',
    'Income',
    'Expense',
  ];

  static const accountValueBalance = 1;
  static const accountValueCash = 2;

  static const tabHome = 0;
  static const tabAccounts = 1;
  static const tabReports = 2;

  static const List<String> tabLabels = [
    'Dashboard',
    'Accounts',
    'Reports',
  ];

  // Screen titles
  static const titleHome = 'Butterfly Finance';
  static const titleAddTransaction = 'New entry';
  static const titleEditTransaction = 'Edit entry';
  static const datePickerLabel = 'Change';
  static const titleAddAccount = 'New Account';
  static const titleEditAccount = 'Edit Account';

  static const labelTxnDate = 'Transaction Date';
  static const labelTxnAmount = 'Amount';
  static const labelTxnDesc = 'Description';

  static const labelAccountName = 'Account Name';
  static const labelAccountDesc = 'Description';

  static const btnSave = 'Save';
  static const btnCancel = 'Cancel';

  static const infoTransactionDelete = 'Transaction Deleted';
  static const errInvalidAmount = 'Please enter a valid amount';
  static const errInvalidAccountType = 'Please select a valid account type';
  static const errInvalidAccountName = 'Please enter a valid account name';

  static const infoAccountDelete = 'TODO: Account Deleted';

// padding
  static const paddingHeight = 8.0;
  static const paddingWidth = 8.0;

  // dividers
  static const dividerHeight = 20.0;

  // input size
  static const buttonWidth = 100.0;
  static const buttonHeight = 45.0;
  static const toggleWidth = 72.0;
  static const toggleRadius = 24.0;
  static const textFieldHeight = 100.0;

  // Options
  static const decimalPlaces = 2;

  static Color? colorDeleteSwipes = Colors.deepOrange.shade100;
  static Color? colorErrorMessage = Colors.red;

  static const indexNewRecord = 0;
  static const invalidAmount = 0.0;
}
