import 'package:intl/intl.dart';
import '../utils/constants.dart';

class TransactionModel {
  final int txnId;
  final DateTime txnDate;
  final String description;
  final double amount;

  TransactionModel(
      {required this.txnDate,
      this.amount = 0.0,
      this.description = '',
      this.txnId = Constants.indexNewRecord});

  TransactionModel.fromMap(Map<String, dynamic> res)
      : txnId = res['txnId'],
        txnDate = DateTime.parse(res['txnDate']),
        description = res['description'],
        amount = res['amount'];

  Map<String, Object?> toMap() {
    return {
      // 'txnId': txnId,
      'txnDate': DateFormat('yyyy-MM-dd').format(txnDate),
      'description': description,
      'amount': amount,
    };
  }
}
