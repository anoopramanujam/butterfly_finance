class TransactionModel {
  TransactionModel(
      {required this.txnDate, required this.amount, this.description = ''});

  final DateTime txnDate;
  final String description;
  final double amount;
}
