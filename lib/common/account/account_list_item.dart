import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../../utils/constants.dart';
import '../../models/account_model.dart';
// import '../../notifiers/account_notifier.dart';
// import '../../screens/transactions/transaction_screen.dart';

// Each item in the account list
class AccountListItem extends StatelessWidget {
  const AccountListItem({Key? key, required this.account}) : super(key: key);

  final AccountModel account;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.none,
      background: Container(color: Constants.colorDeleteSwipes),
      onDismissed: (direction) async {
        // await context.read<AccountNotifier>().delete(account.accountId);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: const Text(Constants.infoAccountDelete)));
      },
      child: (ListTile(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(account.name),
          ],
        ),
        // subtitle: Text(txnDate),
        // onTap: () {
        //   Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => TransactionScreen(
        //               transaction: transaction,
        //             )),
        //   );
        // },
      )),
    );
  }
}
