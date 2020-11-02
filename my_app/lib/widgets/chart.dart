import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      double totalSum = 0.0;

      for (Transaction tx in recentTransactions) {
        if (_sameDay(tx, weekDay)) totalSum += tx.getValue();
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionValues.map((data) {
              return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'],
                      data['amount'],
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending));
            }).toList()),
      ),
    );
  }

  /// ### Verify if a transaction [tx] was made in the same day as [d]
  ///
  /// * returns a [bool] if the condition is true or false
  bool _sameDay(Transaction tx, DateTime d) {
    return tx.getDateTime().day == d.day &&
        tx.getDateTime().month == d.month &&
        tx.getDateTime().year == d.year;
  }
}
