import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double transactionPctOfTotal;
  ChartBar(this.label, this.spendingAmount, this.transactionPctOfTotal);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
          child: FittedBox(
            child: Text(
              '\$${spendingAmount.toStringAsFixed(0)}',
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // ignore: sized_box_for_whitespace
        Container(
          height: 60,
          width: 10,
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1.0),
                  color: Color.fromRGBO(220, 220, 220, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              FractionallySizedBox(
                heightFactor: transactionPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 248, 100, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )
            ],
          ), // It helps to place things on top of each other in three dimensional space
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
