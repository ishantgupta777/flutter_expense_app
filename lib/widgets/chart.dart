import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/Transaction.dart';
import './ChartBar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get recentGroupedTransactions {
    return List.generate(7, (index) {
      var day = DateTime.now().subtract(Duration(days: index));
      var amount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.weekday == day.weekday) {
          amount += recentTransactions[i].amount;
        }
      }
      return {'day': DateFormat.E().format(day), 'amount': amount};
    }).reversed.toList();
  }

  double get totalRecentAmount {
    return recentTransactions.fold(0.0, (value, item) {
      return value + item.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        elevation: 6,
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
        child: Row(
          children: <Widget>[
            ...recentGroupedTransactions.map((tx) {
              return ChartBar(
                  tx['day'],
                  tx['amount'],
                  totalRecentAmount == 0
                      ? 0
                      : (tx['amount'] as double) / totalRecentAmount);
            }).toList()
          ],
        ),
      ),
    );
  }
}
