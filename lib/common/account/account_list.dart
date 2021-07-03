import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/account_model.dart';
import '../../notifiers/account_notifier.dart';
import './account_list_item.dart';
import '../../utils/constants.dart';

class AccountList extends StatefulWidget {
  @override
  _AccountListState createState() => _AccountListState();
}

class _AccountListState extends State<AccountList> {
  // Future<List<AccountModel>>? _assets;
  // Future<List<AccountModel>>? _liabilities;
  // Future<List<AccountModel>>? _incomes;
  // Future<List<AccountModel>>? _expenses;

  Future<List<AccountModel>>? _accounts;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // transactions = Provider.of<TransactionNotifier>(context).transactions;
    final accountNotifier = Provider.of<AccountNotifier>(context);
    // _assets = accountNotifier.getAccounts(Constants.accountAsset);
    // _liabilities = accountNotifier.getAccounts(Constants.accountLiability);
    // _incomes = accountNotifier.getAccounts(Constants.accountIncome);
    // _expenses = accountNotifier.getAccounts(Constants.accountExpense);

    // _accounts = (_assets ?? []) +
    //     (_liabilities ?? []) +
    //     (_incomes ?? []) +
    //     (_expenses ?? []);

    _accounts = accountNotifier.getAllAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AccountModel>>(
        future: _accounts,
        builder:
            (BuildContext context, AsyncSnapshot<List<AccountModel>> snapshot) {
          if (snapshot.hasData) {
            final realAccounts = snapshot.data ?? [];

            List<Widget> listAccounts = [];

            // to display account type headings
            int _currentType = 0;
            int _previousType = -1;

            for (int i = 0; i < realAccounts.length; i++) {
              var _account = realAccounts[i];

              // ignore Balance
              if (_account.type == Constants.accountBalance) {
                continue;
              }

              _currentType = _account.type;
              // type changed, display this new type
              if (_currentType != _previousType) {
                _previousType = _currentType;
                listAccounts.add(ListTile(
                  title: Text(
                    Constants.accountLabels[_account.type],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ));
              }
              listAccounts.add(AccountListItem(account: realAccounts[i]));
            }
            final divided = realAccounts.isNotEmpty
                ? ListTile.divideTiles(tiles: listAccounts, context: context)
                    .toList()
                : <Widget>[];
            return ListView(children: divided);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
