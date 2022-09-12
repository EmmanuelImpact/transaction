import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class TextFieldArea extends StatefulWidget {
  const TextFieldArea({
    Key? key,
    required this.transactionsList,
    required this.addTransactions,
    required this.pickDate,
    required this.chosenDate,
  }) : super(key: key);

  final List<TransactionModel> transactionsList;
  final Function addTransactions;
  final Function() pickDate;
  final DateTime? chosenDate;
  @override
  State<TextFieldArea> createState() => _TextFieldAreaState();
}

class _TextFieldAreaState extends State<TextFieldArea> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitForm() {
    String theTitle = titleController.text;
    double theAmount = double.parse(
      amountController.text,
    );

    if (theTitle.isEmpty || theAmount < 0) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Enter appropriate values',
          ),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    widget.addTransactions(
      txTitle: theTitle,
      txAmount: theAmount,
      pickedDate: widget.chosenDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 20,
        ),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Enter title',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: titleController,
                  onSubmitted: (_) => submitForm(),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    hintText: 'Enter amount',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  controller: amountController,
                  onSubmitted: (_) => submitForm(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.chosenDate == null
                          ? 'No Date Picked'
                          : 'Picked Date: ${DateFormat.yMMMd().format(widget.chosenDate!)}',
                      style: const TextStyle(
                        color: Color.fromRGBO(0, 0, 128, 1),
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: widget.pickDate,
                      child: const Text(
                        'Choose date',
                        style: TextStyle(
                          color: Color.fromRGBO(0, 100, 0, 1),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: submitForm,
                  child: const Text(
                    'Add Transaction',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(0, 100, 0, 1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
