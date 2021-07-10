import 'package:butterfly_finance/models/account_model.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../common/account/account_add_edit.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({Key? key, required this.account}) : super(key: key);

  final AccountModel account;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(account.accountId == Constants.indexNewRecord
              ? Constants.titleAddAccount
              : Constants.titleEditAccount),
        ),
        body: AccountAddEdit(
          account: account,
        ));
  }
}
