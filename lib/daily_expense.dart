import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';
import 'package:new_abc/data/expense_data.dart';

class DailyExpensePage extends StatefulWidget {
  @override
  _DailyExpensePageState createState() => _DailyExpensePageState();
}

class _DailyExpensePageState extends State<DailyExpensePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final expenseData = Provider.of<ExpenseData>(context);
    final dailyExpensesSummary = expenseData.getDailyExpensesSummary();

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Expenses'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Tap on a card to see full details of your daily expenses.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: dailyExpensesSummary.length,
              itemBuilder: (context, index) {
                final entry = dailyExpensesSummary.entries.elementAt(index);
                final date = entry.key;
                final totalAmount = entry.value;

                return Column(
                  children: [
                    FlipCard(
                      direction: FlipDirection.VERTICAL,
                      front: Card(
                        color: Colors.grey[700],
                        margin: EdgeInsets.symmetric(vertical: 16.0),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                          title: Text(
                            '${date.toLocal()}'.split(' ')[0],
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).textTheme.titleLarge?.color,
                            ),
                          ),
                          subtitle: Text(
                            'Total: \Rs ${totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                      back: Card(
                        color: Colors.grey[700],
                        margin: EdgeInsets.symmetric(vertical: 8.0),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Column(
                          children: expenseData.getExpensesForDay(date).map((expense) {
                            return ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                              title: Text(
                                expense.name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
                                ),
                              ),
                              subtitle: Text(
                                '\Rs ${expense.amount.toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Theme.of(context).textTheme.bodySmall?.color,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    if (index < dailyExpensesSummary.length - 1)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Lottie.asset(
                          'assets/down.json', // Replace with your Lottie file path
                          width: 100, // Adjust the size as needed
                          repeat: true,
                          animate: true,
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
