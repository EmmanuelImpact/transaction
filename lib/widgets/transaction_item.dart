import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key? key,
    required this.title,
    required this.amount,
    required this.date,
    required this.deleteTx,
    required this.id,
  }) : super(key: key);

  final String title;
  final double amount;
  final DateTime date;
  final Function({required String txId}) deleteTx;
  final String id;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color? _shuffle;

  @override
  void initState() {
    // ignore: no_leading_underscores_for_local_identifiers
    final _colorsList = [
      Colors.yellow,
      Colors.pink,
      Colors.red,
      Colors.indigo,
      Colors.orange,
    ];
    _shuffle = _colorsList[Random().nextInt(5)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _shuffle,
            radius: 30,
            child: FittedBox(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  '\$${widget.amount.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            DateFormat('dd-MM-yyyy').format(widget.date),
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),
          // ignore: deprecated_member_use
          trailing: FlatButton.icon(
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            ),
            label: Text(
              'Delete',
              style: TextStyle(
                color: Theme.of(context).errorColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () => widget.deleteTx(txId: widget.id),
          ),
        ),
      ),
    );
  }
}
