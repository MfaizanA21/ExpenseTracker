import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_abc/data/expense_data.dart';
import 'package:new_abc/models/expense_item.dart';

class WeeklyExpensePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final expenseData = Provider.of<ExpenseData>(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Weekly Expenses'),

          ],
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(

        child: Padding(
          padding: const EdgeInsets.all(16.0

          ),


          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Week Selection with modern button style
              Center(
                child: Text(
                  _formatWeekLabel(expenseData.currentWeekStart),
                  style: theme.textTheme.bodyMedium?.copyWith(fontSize: 30,fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: expenseData.currentWeekStart,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          expenseData.setWeekStart(pickedDate);
                        }
                      },
                      icon: Icon(Icons.calendar_today_outlined),
                      label: Text('Select Week'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.grey[700],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.0),


              Consumer<ExpenseData>(
                builder: (context, expenseData, child) {
                  final weeklyExpenses = expenseData.getWeeklyExpensesForWeek(expenseData.currentWeekStart);
                  final totalExpenditure = weeklyExpenses.fold<double>(0.0, (sum, expense) => sum + expense.amount);

                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Expense:',
                            style: theme.textTheme.bodyMedium?.copyWith(fontSize: 15,fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '\Rs ${totalExpenditure.toStringAsFixed(2)}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                            color: Colors.grey[550],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),

              // Weekly Expense Details with modern list and rounded cards
              Consumer<ExpenseData>(
                builder: (context, expenseData, child) {
                  final weeklyExpenses = expenseData.getWeeklyExpensesForWeek(expenseData.currentWeekStart);
                  if (weeklyExpenses.isEmpty) {
                    return Center(
                      child: Text(
                        'No expenses recorded for this week',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(16.0),
                    itemCount: weeklyExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = weeklyExpenses[index];
                      return ExpenseDetailCard(expense: expense);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatWeekLabel(DateTime startOfWeek) {
    final weekOfMonth = ((startOfWeek.day - 1) / 7).ceil() + 1;
    final monthName = _getMonthName(startOfWeek.month);
    return '${_getWeekName(weekOfMonth)} of $monthName';
  }

  String _getWeekName(int week) {
    switch (week) {
      case 1: return 'First Week';
      case 2: return 'Second Week';
      case 3: return 'Third Week';
      default: return 'Last Week';
    }
  }

  String _getMonthName(int month) {
    const monthNames = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return monthNames[month - 1];
  }
}

class ExpenseDetailCard extends StatelessWidget {
  final ExpenseItem expense;

  const ExpenseDetailCard({required this.expense});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = Colors.grey[800]; // Consistent card color
    final textColor = Colors.white; // Text color consistent with tile
    final secondaryColor = Colors.green[300]; // Consistent secondary color

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: cardColor,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    expense.name,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: textColor,
                    ),
                  ),
                ),

              ],
            ),
            SizedBox(height: 6),
            Text(
              'Rs ${expense.amount.toStringAsFixed(2)}',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: secondaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(
              'Date: ${expense.dateTime.day.toString().padLeft(2, '0')}/${expense.dateTime.month.toString().padLeft(2, '0')}/${expense.dateTime.year}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor.withOpacity(0.7),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );

  }
}


