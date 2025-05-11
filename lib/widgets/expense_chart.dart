import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/transaction.dart';
import '../constants/app_constants.dart';

class ExpenseChart extends StatelessWidget {
  final List<Transaction> transactions;

  const ExpenseChart({Key? key, required this.transactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalAmount = transactions.fold(0.0, (sum, t) => sum + t.amount.abs());
    final categorySums = <String, double>{};
    for (var t in transactions) {
      categorySums[t.category] = (categorySums[t.category] ?? 0) + t.amount.abs();
    }

    final colors = [Colors.purple, Colors.pink, Colors.green, Colors.teal, Colors.blue];
    // Convert categorySums.entries to a List before using asMap()
    final sections = categorySums.entries.toList().asMap().entries.map((e) {
      return PieChartSectionData(
        color: colors[e.key % colors.length],
        value: e.value.value,
        radius: 80,
        title: '',
      );
    }).toList();

    return SizedBox(
      height: 250,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sections: sections.isEmpty
                  ? [
                PieChartSectionData(
                  color: Colors.grey,
                  value: 1,
                  radius: 80,
                  title: '',
                )
              ]
                  : sections,
              centerSpaceRadius: 70,
              sectionsSpace: 4,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '\$${totalAmount.abs().toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              Text(
                'Netflix Expenses',
                style: TextStyle(fontSize: 16, color: AppConstants.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}