import 'package:expenses/components/chart_bar.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/tansaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction) {
    Intl.defaultLocale = 'pt_BR';
  }

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double total = 0.0;

      for (var i = 0; i < recentTransaction.length; i++) {
        bool sameDay = recentTransaction[i].date.day == weekDay.day;
        bool sameMonth = recentTransaction[i].date.month == weekDay.month;
        bool sameYear = recentTransaction[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          total += recentTransaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay)[0].toUpperCase(),
        'value': total,
      };
    }).reversed.toList();
  }

  double get _weekTotalAmount {
    return groupedTransactions.fold(
        0.0, (previousValue, element) => previousValue + element['value']);
  }

  @override
  Widget build(BuildContext context) {
    groupedTransactions;
    return Card(
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.4,
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((e) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: e['day'],
                      amount: e['value'],
                      percentage: _weekTotalAmount == 0
                          ? 0
                          : (e['value'] as double) / _weekTotalAmount,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
