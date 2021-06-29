import 'package:intl/intl.dart';
import '../utils/constants.dart';

class TransactionModel {
  final int txnId;
  final DateTime txnDate;
  final String description;
  final double amount;

  TransactionModel({
    required this.txnDate,
    this.amount = 0.0,
    this.description = '',
    this.txnId = Constants.indexNewRecord,
  });

  TransactionModel.fromMap(Map<String, dynamic> res)
      : txnId = res['txnId'],
        txnDate = DateTime.parse(res['txnDate']),
        description = res['description'],
        amount = res['amount'];

  // No txnId needed since it is an autoincrement key
  Map<String, Object?> toMap() => {
        // Date is stored in database in '2021-06-22' format
        'txnDate': DateFormat('yyyy-MM-dd').format(txnDate),
        'description': description,
        'amount': amount,
      };
}
