import 'dart:ui';

import 'package:butterfly_finance/models/transaction_model.dart';
import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../../screens/transactions/transaction_screen.dart';
import '../../common/transaction/transaction_list.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              icon: Icon(Icons.view_agenda_outlined),
              text: Constants.tabHome,
            ),
            Tab(
                icon: Icon(Icons.account_balance_outlined),
                text: Constants.tabAccounts),
            Tab(
                icon: Icon(Icons.insights_outlined),
                text: Constants.tabReports),
          ],
        ),
        title: const Text(Constants.titleHome),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          TransactionList(),
          Icon(Icons.directions_transit),
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
