import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return recentTransactions.fold(0.0, (sum, item) {
      return sum + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        // you could have used container instead of padding but
        // well the container is only for padding so..
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
              // items will take the maximum space with equal space around them
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionValues.map((data) {
                return Flexible(
                  // tight sets the widget to fit whole area unlike loose
                  // setting all children to tight will ensure they have the same width
                  // you can use Expandable widget in place of FlexFit.tight
                  // flex: 2 - will take double space etc
                  fit: FlexFit.tight,
                  child: ChartBar(
                    label: data['day'],
                    spendingAmount: data['amount'],
                    spendingPerc: totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending,
                  ),
                );
              }).toList()),
        ));
  }
}
