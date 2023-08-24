import 'package:expense_tracker_app/charBar.dart';
import 'package:expense_tracker_app/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTansactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].time.day == weekDay.day &&
            recentTransactions[i].time.month == weekDay.month &&
            recentTransactions[i].time.year == weekDay.year) {
          totalSum += recentTransactions[i].money;
        }
      }

      return {
        'day': DateFormat.E()
            .format(weekDay)
            .substring(0, 3), // shortcut for retrieving weekday value
        'amount': totalSum
      }; //curly braces beacuase we are returing maps
    }).toList();
  }

  double get maxSpending {
    return groupedTansactionValue.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    // print(groupedTansactionValue);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTansactionValue.map((data) {
            return Flexible(
              fit: FlexFit
                  .tight, // we assign each child within a defined spcae and don't let it grow with tight property
              child: ChartBar(
                  data['day'].toString(),
                  (data['amount'] as double),
                  maxSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / maxSpending),
            );
          }).toList(),
        ),
      ),
    );
  }
}
