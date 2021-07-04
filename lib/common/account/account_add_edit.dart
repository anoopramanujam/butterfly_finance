import 'package:butterfly_finance/models/account_model.dart';
import 'package:butterfly_finance/notifiers/account_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

import '../../common/my_button.dart';
import '../../common/my_textfield.dart';

/// Add and Edit transactions
class AccountAddEdit extends StatefulWidget {
  const AccountAddEdit({Key? key, required this.account}) : super(key: key);

  final AccountModel account;
  @override
  _AccountAddEditState createState() => _AccountAddEditState();
}

class _AccountAddEditState extends State<AccountAddEdit> {
  // transaction columns
  late int _accountId;
  late String _name;
  late String _description;

  // textbox controllers
  late TextEditingController _descriptionController;
  late TextEditingController _nameController;

  late List<bool> _selections;
  late int _selectedAccount;

  @override
  void initState() {
    super.initState();
    _accountId = widget.account.accountId;
    _description = widget.account.description;
    _name = widget.account.name;
    _descriptionController = TextEditingController(text: _description);
    _nameController = TextEditingController(text: _name);
    _selections = List.generate(
        4, (index) => (index == widget.account.type - 1) ? true : false);
    _selectedAccount = widget.account.type;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Constants.paddingWidth, vertical: 0),
            child: Column(
              children: [
                SizedBox(
                  height: Constants.dividerHeight,
                ),
                ToggleButtons(
                  borderRadius: BorderRadius.circular(Constants.toggleRadius),
                  children: <Widget>[
                    SizedBox(
                        width: Constants.toggleWidth,
                        child: Center(
                            child: Text(Constants
                                .accountLabels[Constants.accountAsset]))),
                    SizedBox(
                        width: Constants.toggleWidth,
                        child: Center(
                            child: Text(Constants
                                .accountLabels[Constants.accountLiability]))),
                    SizedBox(
                        width: Constants.toggleWidth,
                        child: Center(
                            child: Text(Constants
                                .accountLabels[Constants.accountIncome]))),
                    SizedBox(
                        width: Constants.toggleWidth,
                        child: Center(
                            child: Text(Constants
                                .accountLabels[Constants.accountExpense]))),
                  ],
                  onPressed: (int index) {
                    setState(() {
                      for (int buttonIndex = 0;
                          buttonIndex < _selections.length;
                          buttonIndex++) {
                        if (buttonIndex == index) {
                          _selections[buttonIndex] = true;
                          // we are ignoring Balance Account
                          _selectedAccount = index + 1;
                        } else {
                          _selections[buttonIndex] = false;
                        }
                      }
                    });
                  },
                  isSelected: _selections,
                ),
                SizedBox(
                  height: Constants.dividerHeight,
                ),
                // Amount field
                MyTextField(
                  controller: _nameController,
                  hintText: Constants.labelAccountName,
                ),
                // Description field
                MyTextField(
                  controller: _descriptionController,
                  hintText: Constants.labelAccountDesc,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyButton(
                      label: Constants.btnCancel,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    MyButton(
                      label: Constants.btnSave,
                      onPressed: () async {
                        if (_selectedAccount == Constants.accountBalance) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text(Constants.errInvalidAccountType),
                            backgroundColor: Constants.colorErrorMessage,
                          ));
                          return;
                        }
                        if (_nameController.text.trim() == '') {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                const Text(Constants.errInvalidAccountName),
                            backgroundColor: Constants.colorErrorMessage,
                          ));
                          return;
                        }

                        final account = AccountModel(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          type: _selectedAccount,
                        );

                        if (_accountId == Constants.indexNewRecord) {
                          context.read<AccountNotifier>().add(account);
                        } else {
                          context
                              .read<AccountNotifier>()
                              .update(account, _accountId);
                        }

                        Navigator.pop(context);
                      },
                    ),
                  ],
                )
              ],
            )));
  }
}
