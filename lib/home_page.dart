import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_abc/drawer/drawer.dart';
import 'package:new_abc/theme/theme_notifier.dart'; // Import the ThemeNotifier
import 'package:another_flushbar/flushbar.dart';  // Import Flushbar

import 'components/expense_summary.dart';
import 'components/expense_tile.dart';
import 'data/expense_data.dart';

import 'models/expense_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<ExpenseData>(context, listen: false).prepareData();
  }

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,
          title: Text(
            'Add New Expense',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newExpenseNameController,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  labelText: 'Expense Name',
                  labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: newExpenseAmountController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: cancel,
              child: Text('Cancel', style: TextStyle(color: theme.textTheme.labelLarge?.color)),
            ),
            TextButton(
              onPressed: save,
              child: Text('Save', style: TextStyle(color: theme.textTheme.labelLarge?.color)),
            ),
          ],
        );
      },
    );
  }

  void editExpense(int index, ExpenseItem expense) {
    newExpenseNameController.text = expense.name;
    newExpenseAmountController.text = expense.amount.toString();

    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        return AlertDialog(
          backgroundColor: theme.dialogBackgroundColor,
          title: Text(
            'Edit Expense',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.titleLarge?.color,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newExpenseNameController,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  labelText: 'Expense Name',
                  labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: newExpenseAmountController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: theme.textTheme.bodyLarge?.color),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: TextStyle(color: theme.textTheme.bodyMedium?.color),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: cancel,
              child: Text('Cancel', style: TextStyle(color: theme.textTheme.labelLarge?.color)),
            ),
            TextButton(
              onPressed: () => update(index),
              child: Text('Update', style: TextStyle(color: theme.textTheme.labelLarge?.color)),
            ),
          ],
        );
      },
    );
  }

  void update(int index) {
    ExpenseItem updatedExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: double.parse(newExpenseAmountController.text),
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false)
        .updateExpense(index, updatedExpense);
    Navigator.pop(context);
    clear();
    showFlushbar("Expense updated successfully!");
  }

  void deleteExpense(int index) {
    Provider.of<ExpenseData>(context, listen: false).deleteExpense(index);
    showFlushbar("Expense deleted successfully!");
  }

  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: double.parse(newExpenseAmountController.text),
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addExpense(newExpense);
    Navigator.pop(context);
    clear();
    showFlushbar("Expense added successfully!");
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  void showFlushbar(String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.BOTTOM,
      backgroundColor: Colors.black54,
      margin: EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      icon: Icon(
        Icons.check,
        color: Colors.white,
      ),
    )..show(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Expense Tracker',
              style: TextStyle(color: theme.textTheme.titleLarge?.color, fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: theme.appBarTheme.backgroundColor,
          actions: [
            // Theme switch button
            IconButton(
              icon: Icon(theme.brightness == Brightness.dark ? Icons.nightlight_round : Icons.wb_sunny),
              onPressed: () {
                final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
                themeNotifier.toggleTheme();
              },
            ),
          ],
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(40.0),
          child: GestureDetector(
            onTap: addNewExpense,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black45, Colors.black54],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, color: Colors.white, size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Add New Expense',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            ExpenseSummary(startOfWeek: value.startOfWeekData()),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: value.getAllExpenseList().length,
              itemBuilder: (context, index) {
                final expense = value.getAllExpenseList()[index];
                return Column(
                  children: [
                    SizedBox(height: 4),
                    ExpenseTile(
                      name: expense.name,
                      amount: expense.amount.toString(),
                      dateTime: expense.dateTime,
                      deleteTapped: (context) => deleteExpense(index),
                      editTapped: (context) => editExpense(index, expense),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
        drawer: MyDrawer(),
      ),
    );
  }
}
