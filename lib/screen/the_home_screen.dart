import 'dart:io';

import 'package:flutter/material.dart';
import '../widgets/transactions_list.dart';
import '../widgets/textfield_area.dart';
import '../models/transaction_model.dart';

import '../widgets/chart.dart';
import 'package:flutter/cupertino.dart';

class TheHomeScreen extends StatefulWidget {
  const TheHomeScreen({Key? key}) : super(key: key);

  @override
  State<TheHomeScreen> createState() => _TheHomeScreenState();
}

class _TheHomeScreenState extends State<TheHomeScreen> {
  DateTime? _pickedDate;
  final List<TransactionModel> transactionsList = [];

  void _addTransactions({
    required String txTitle,
    required double txAmount,
    required DateTime pickedDate,
  }) {
    final newTx = TransactionModel(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: pickedDate,
    );
    setState(() {
      transactionsList.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void _modalSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.opaque,
            child: TextFieldArea(
              transactionsList: transactionsList,
              addTransactions: _addTransactions,
              pickDate: _pickDate,
              chosenDate: _pickedDate,
            ),
          );
        });
  }

  List<TransactionModel> get _recentTransactions {
    return transactionsList.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _pickedDate = pickedDate;
        });
      }
    });
  }

  var _switch = false;

  Widget landScape({
    required bool theOrientation,
    required AppBar appBar,
    required BuildContext context,
  }) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: theOrientation
          ? (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              0.8
          : (MediaQuery.of(context).size.height -
                  appBar.preferredSize.height -
                  MediaQuery.of(context).padding.top) *
              0.3,
      child: SingleChildScrollView(
        child: Chart(
          recentTransactions: _recentTransactions,
        ),
      ),
    );
  }

  Widget isPortrait({
    required AppBar appBar,
    required BuildContext context,
  }) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          1,
      child: SingleChildScrollView(
        child: TransactionsList(
          transactionsList: transactionsList,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? const CupertinoNavigationBar()
        : AppBar(
            title: const Text(
              'Personal Transactions',
            ),
          ) as PreferredSizeWidget;
    final pageBody = SingleChildScrollView(
      child: Column(
        children: [
          if (isLandScape)
            Switch.adaptive(
              value: _switch,
              onChanged: (value) {
                setState(() {
                  _switch = value;
                });
              },
              activeColor: Colors.yellow,
              inactiveTrackColor: Colors.white70,
            ),
          // ignore: sized_box_for_whitespace
          if (_switch)
            if (isLandScape)
              // ignore: sized_box_for_whitespace
              landScape(
                theOrientation: isLandScape,
                appBar: appBar as AppBar,
                context: context,
              ),
          // ignore: sized_box_for_whitespace
          if (!isLandScape)
            // ignore: sized_box_for_whitespace
            isPortrait(
              appBar: appBar as AppBar,
              context: context,
            ),
        ],
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            navigationBar: appBar as ObstructingPreferredSizeWidget,
            child: pageBody,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            backgroundColor: const Color.fromRGBO(0, 0, 128, 1),
            floatingActionButton: FloatingActionButton(
              child: const Icon(
                Icons.person,
                size: 40,
              ),
              onPressed: () => _modalSheet(context),
            ),
            /*  floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat, */
          );
  }
}
