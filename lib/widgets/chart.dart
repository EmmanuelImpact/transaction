import 'package:flutter/material.dart';
import 'package:transactions/widgets/chart_bar_item.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  const Chart({
    Key? key,
    required this.recentTransactions,
  }) : super(key: key);
  final List<TransactionModel> recentTransactions;

  List<Map<String, dynamic>> get curledOutData {
    return List.generate(7, (index) {
      final weekDayLabel = DateTime.now().subtract(
        Duration(days: index),
      );
      var sumForADay = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (weekDayLabel.day == recentTransactions[i].date.day &&
            weekDayLabel.month == recentTransactions[i].date.month &&
            weekDayLabel.year == recentTransactions[i].date.year) {
          sumForADay += recentTransactions[i].amount;
        }
      }
      return {
        'label': DateFormat.E().format(weekDayLabel),
        'singleDaySum': sumForADay,
      };
    }).reversed.toList();
  }

  double get entireTotal {
    return curledOutData.fold(0.0, (sum, items) {
      return sum + items['singleDaySum'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 100,
      child: Container(
        height: 260,
        padding: const EdgeInsets.only(top: 16, bottom: 16),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: curledOutData.map((data) {
            return ChartBarItem(
              label: data['label'].toString(),
              totalAmountForEachDay: (data['singleDaySum'] as double),
              fractionInSevenDays: entireTotal == 0
                  ? 0
                  : (data['singleDaySum'] as double) / entireTotal,
            );
          }).toList(),
        ),
      ),
    );
  }
}
