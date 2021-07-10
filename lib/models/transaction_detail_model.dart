class TransactionDetailModel {
  final int txnId;
  final DateTime txnDate;
  final String description;
  final double amount;
  final int fromAccount;
  final int toAccount;
  final int type;
  final String fromAccountName;
  final String toAccountName;

  TransactionDetailModel.fromMap(Map<String, dynamic> res)
      : txnId = res['txnId'],
        txnDate = DateTime.parse(res['txnDate']),
        description = res['description'],
        amount = res['amount'],
        fromAccount = res['fromAccount'],
        toAccount = res['toAccount'],
        type = res['type'],
        fromAccountName = res['fromAccountName'],
        toAccountName = res['toAccountName'];
}
