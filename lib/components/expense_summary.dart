import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../bar graph/bar_graph.dart';
import '../data/expense_data.dart';
import '../datetime/date_time_helper.dart';


class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;

  const ExpenseSummary({super.key, required this.startOfWeek});

  double calculateMax(
      ExpenseData value,
      String sunday, String monday, String tuesday, String wednesday, String thursday, String friday, String saturday,
      ) {
    double max = 100;
    List<double> values = [
      value.calculateDailyExpensesSummary()[sunday] ?? 0,
      value.calculateDailyExpensesSummary()[monday] ?? 0,
      value.calculateDailyExpensesSummary()[tuesday] ?? 0,
      value.calculateDailyExpensesSummary()[wednesday] ?? 0,
      value.calculateDailyExpensesSummary()[thursday] ?? 0,
      value.calculateDailyExpensesSummary()[friday] ?? 0,
      value.calculateDailyExpensesSummary()[saturday] ?? 0,
    ];
    values.sort();
    max = values.last * 1.1;
    return max == 0 ? 100 : max;
  }

  double calculateWeekTotal(
      ExpenseData value,
      String sunday, String monday, String tuesday, String wednesday, String thursday, String friday, String saturday,
      ) {
    List<double> values = [
      value.calculateDailyExpensesSummary()[sunday] ?? 0,
      value.calculateDailyExpensesSummary()[monday] ?? 0,
      value.calculateDailyExpensesSummary()[tuesday] ?? 0,
      value.calculateDailyExpensesSummary()[wednesday] ?? 0,
      value.calculateDailyExpensesSummary()[thursday] ?? 0,
      value.calculateDailyExpensesSummary()[friday] ?? 0,
      value.calculateDailyExpensesSummary()[saturday] ?? 0,
    ];
    double total = 0;
    for (var value in values) {
      total += value;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    String sunday = convertDateTimeToString(startOfWeek.add(const Duration(days: 0)));
    String monday = convertDateTimeToString(startOfWeek.add(const Duration(days: 1)));
    String tuesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 2)));
    String wednesday = convertDateTimeToString(startOfWeek.add(const Duration(days: 3)));
    String thursday = convertDateTimeToString(startOfWeek.add(const Duration(days: 4)));
    String friday = convertDateTimeToString(startOfWeek.add(const Duration(days: 5)));
    String saturday = convertDateTimeToString(startOfWeek.add(const Duration(days: 6)));

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Weekly Total:',
                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    'Rs ${calculateWeekTotal(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday).toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 18,color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 250, // Adjust the height as needed
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: MyBarGraph(
                  maxY: calculateMax(value, sunday, monday, tuesday, wednesday, thursday, friday, saturday),
                  sunAmount: value.calculateDailyExpensesSummary()[sunday] ?? 0,
                  monAmount: value.calculateDailyExpensesSummary()[monday] ?? 0,
                  tueAmount: value.calculateDailyExpensesSummary()[tuesday] ?? 0,
                  wedAmount: value.calculateDailyExpensesSummary()[wednesday] ?? 0,
                  thurAmount: value.calculateDailyExpensesSummary()[thursday] ?? 0,
                  friAmount: value.calculateDailyExpensesSummary()[friday] ?? 0,
                  satAmount: value.calculateDailyExpensesSummary()[saturday] ?? 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
