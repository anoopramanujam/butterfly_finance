import 'package:intl/intl.dart';
import '../utils/constants.dart';

class TransactionModel {
  final int txnId;
  final DateTime txnDate;
  final String description;
  final double amount;
  final int fromAccount;
  final int toAccount;
  final int type;

  TransactionModel({
    required this.txnDate,
    this.amount = 0.0,
    this.description = '',
    this.txnId = Constants.indexNewRecord,
    this.fromAccount = Constants.accountBalance,
    this.toAccount = Constants.accountBalance,
    this.type = Constants.txnExpense,
  });

  TransactionModel.fromMap(Map<String, dynamic> res)
      : txnId = res['txnId'],
        txnDate = DateTime.parse(res['txnDate']),
        description = res['description'],
        amount = res['amount'],
        fromAccount = res['fromAccount'],
        toAccount = res['toAccount'],
        type = res['type'];

  // No txnId needed since it is an autoincrement key
  Map<String, Object?> toMap() => {
        // Date is stored in database in '2021-06-22' format
        'txnDate': DateFormat('yyyy-MM-dd').format(txnDate),
        'description': description,
        'amount': amount,
        'fromAccount': fromAccount,
        'toAccount': toAccount,
        'type': type,
      };
}
