import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_abc/models/expense_item.dart';

class HiveDatabase {
  final _myBox = Hive.box("expense_database"); // Consistent box name
  static const String allExpensesKey = "ALL_EXPENSES";
  static const String spendingLimitKey = "SPENDING_LIMIT";
  static const String totalSpentKey = "TOTAL_SPENT";

  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];
    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime.toIso8601String(), // Convert DateTime to ISO 8601 string
      ];
      allExpensesFormatted.add(expenseFormatted);
    }
    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES") ?? [];
    List<ExpenseItem> allExpenses = [];
    for (var savedExpense in savedExpenses) {
      String name = savedExpense[0];
      double amount = double.parse(savedExpense[1].toString()); // Convert to double
      DateTime dateTime = DateTime.parse(savedExpense[2]); // Convert from ISO 8601 string

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
      );
      allExpenses.add(expense);
    }

    return allExpenses;
  }

}
