import 'package:flutter/material.dart';

class ChartBarItem extends StatelessWidget {
  const ChartBarItem(
      {Key? key,
      required this.label,
      required this.totalAmountForEachDay,
      required this.fractionInSevenDays})
      : super(key: key);

  final String label;
  final double totalAmountForEachDay;
  final double fractionInSevenDays;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          height: 22,
          child: FittedBox(
            child: Text(
              '\$${totalAmountForEachDay.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        // ignore: sized_box_for_whitespace
        Container(
          height: 150,
          width: 40,
          child: Stack(
            children: [
              // ignore: sized_box_for_whitespace
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              FractionallySizedBox(
                heightFactor: fractionInSevenDays,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // ignore: sized_box_for_whitespace
        Container(
          height: 18,
          child: FittedBox(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
