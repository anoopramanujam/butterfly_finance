import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../common/transaction/transaction_add_edit.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({Key? key, required this.transaction})
      : super(key: key);

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(transaction.txnId == Constants.indexNewRecord
              ? Constants.titleAddTransaction
              : Constants.titleEditTransaction),
        ),
        body: TransactionAddEdit(
          transaction: transaction,
        ));
  }
}
