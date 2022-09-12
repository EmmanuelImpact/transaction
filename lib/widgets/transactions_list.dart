import 'package:flutter/material.dart';
import 'package:transactions/models/transaction_model.dart';
import 'package:transactions/widgets/transaction_item.dart';

class TransactionsList extends StatefulWidget {
  const TransactionsList({
    Key? key,
    required this.transactionsList,
  }) : super(key: key);
  final List<TransactionModel> transactionsList;

  @override
  State<TransactionsList> createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  void _deleteTx({required String txId}) {
    setState(() {
      widget.transactionsList.removeWhere((tx) => tx.id == txId);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return widget.transactionsList.isEmpty
        ? Container(
            padding: const EdgeInsets.only(top: 60),
            height: 600,
            alignment: Alignment.center,
            width: double.infinity,
            /* decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Colors.grey,
              ),
            ), */
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'No Transactions added yet.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Click the icon below to start adding some',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        : Container(
            margin: const EdgeInsets.all(2),
            height: 455,
            child: ListView(
              children: widget.transactionsList.map((tx) {
                return TransactionItem(
                  key: ValueKey(tx.id),
                  title: tx.title,
                  amount: tx.amount,
                  date: tx.date,
                  deleteTx: _deleteTx,
                  id: tx.id,
                );
              }).toList(),
            ),
          );
  }
}
