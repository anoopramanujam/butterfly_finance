import '../utils/constants.dart';

class AccountModel {
  final int accountId;
  final String name;
  final int type;
  final String description;

  AccountModel({
    this.accountId = Constants.indexNewRecord,
    required this.name,
    required this.type,
    this.description = '',
  });

  AccountModel.fromMap(Map<String, dynamic> res)
      : accountId = res['accountId'],
        name = res['name'],
        type = res['type'],
        description = res['description'];

  // No txnId needed since it is an autoincrement key
  Map<String, Object?> toMap() => {
        // Date is stored in database in '2021-06-22' format
        'name': name,
        'type': type,
        'description': description,
      };
}
