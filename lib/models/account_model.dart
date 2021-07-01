import '../utils/constants.dart';

class AccountModel {
  final int accountId;
  final String accountName;
  final int accountType;
  final String accountDescription;

  AccountModel({
    this.accountId = Constants.indexNewRecord,
    required this.accountName,
    required this.accountType,
    this.accountDescription = '',
  });

  AccountModel.fromMap(Map<String, dynamic> res)
      : accountId = res['accountId'],
        accountName = res['accountName'],
        accountType = res['accountType'],
        accountDescription = res['accountDescription'];

  // No txnId needed since it is an autoincrement key
  Map<String, Object?> toMap() => {
        // Date is stored in database in '2021-06-22' format
        'accountName': accountName,
        'accountType': accountType,
        'accountDescription': accountDescription,
      };
}
