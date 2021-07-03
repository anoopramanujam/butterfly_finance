import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../screens/transactions/transaction_screen.dart';
import '../../common/transaction/transaction_list.dart';
import '../../common/account/account_list.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(_switchTabs);
  }

  void _switchTabs() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.removeListener(_switchTabs);
    _tabController.dispose();
    super.dispose();
  }

  TabBar get _tabBar => TabBar(
        indicatorColor: Colors.lightGreen.shade400,
        controller: _tabController,
        tabs: [
          Tab(
            icon: Icon(Icons.view_agenda_outlined),
            text: Constants.tabHome,
          ),
          Tab(
              icon: Icon(Icons.account_balance_outlined),
              text: Constants.tabAccounts),
          Tab(icon: Icon(Icons.insights_outlined), text: Constants.tabReports),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: _tabBar.preferredSize,
          child: ColoredBox(
            color: Colors.lightGreen.shade300,
            child: _tabBar,
          ),
        ),
        title: const Text(Constants.titleHome),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TransactionList(),
          AccountList(),
          Icon(Icons.directions_bike),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionScreen(
                            transaction:
                                TransactionModel(txnDate: DateTime.now()),
                          )),
                );
              },
              child: const Icon(Icons.add),
            )
          : Container(),
    );
  }
}
