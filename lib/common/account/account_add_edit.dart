import 'package:butterfly_finance/models/account_model.dart';
import 'package:butterfly_finance/notifiers/account_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants.dart';

import '../../common/my_button.dart';
import '../../common/my_textfield.dart';
import '../../common/my_toggle_button.dart';

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

  late int _selectedAccountType;

  late List<Map> _toggleItems;

  @override
  void initState() {
    super.initState();
    _accountId = widget.account.accountId;
    _description = widget.account.description;
    _name = widget.account.name;
    _descriptionController = TextEditingController(text: _description);
    _nameController = TextEditingController(text: _name);

    _selectedAccountType = widget.account.type;

    const assetTypes = [
      Constants.accountAsset,
      Constants.accountLiability,
      Constants.accountIncome,
      Constants.accountExpense,
    ];
    _toggleItems = assetTypes.map((assetType) {
      return {
        'title': Constants.accountLabels[assetType],
        'value': assetType,
        'isSelected': (widget.account.type == assetType) ? true : false
      };
    }).toList();
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
                MyToggleButton(
                  toggleItems: _toggleItems,
                  onPressed: (int selectedValue) {
                    _selectedAccountType = selectedValue;
                  },
                ),

                SizedBox(
                  height: Constants.dividerHeight,
                ),
                // Name field
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
                        if (!_isValidationOk()) {
                          return;
                        }
                        final account = AccountModel(
                          name: _nameController.text,
                          description: _descriptionController.text,
                          type: _selectedAccountType,
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

  bool _isValidationOk() {
    if (_selectedAccountType == Constants.accountBalance) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(Constants.errInvalidAccountType),
        backgroundColor: Constants.colorErrorMessage,
      ));
      return false;
    }
    if (_nameController.text.trim() == '') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text(Constants.errInvalidAccountName),
        backgroundColor: Constants.colorErrorMessage,
      ));
      return false;
    }
    return true;
  }
}
