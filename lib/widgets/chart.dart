import 'package:expense_project/models/transaction.dart';
import 'package:expense_project/widgets/chartBar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupOfTransactions {
    return List.generate(7, (index) {
      final getDays = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalSum = 0.00;

      for (var idx = 0; idx < recentTransactions.length; idx++) {
        if (recentTransactions[idx].date.day == getDays.day &&
            recentTransactions[idx].date.month == getDays.month &&
            recentTransactions[idx].date.year == getDays.year) {
          totalSum += recentTransactions[idx].amount;
        }
      }
      return {
        'day': DateFormat.E().format(getDays).substring(0, 3),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    return groupOfTransactions.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
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
          children: groupOfTransactions.map((data) {
            return Flexible(
              child: ChartBar(
                data['day'].toString(),
                data['amount'] as double,
                totalSpending == 0
                    ? 0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
