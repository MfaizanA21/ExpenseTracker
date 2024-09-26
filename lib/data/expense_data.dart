import 'package:flutter/cupertino.dart';
import 'package:new_abc/data/hive_database.dart';
import '../datetime/date_time_helper.dart';
import '../models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  List<ExpenseItem> overallExpenseList = [];
  DateTime _currentWeekStart = DateTime.now();

  get db => HiveDatabase();

  DateTime get currentWeekStart => _currentWeekStart;

  void prepareData() {
    overallExpenseList = db.readData();
    notifyListeners(); // Notify listeners after preparing data
  }

  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  void addExpense(ExpenseItem expense) {
    overallExpenseList.add(expense);
    calculateTotalSpent();
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void deleteExpense(int index) {
    overallExpenseList.removeAt(index);
    calculateTotalSpent();
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  void updateExpense(int index, ExpenseItem updatedExpense) {
    overallExpenseList[index] = updatedExpense;
    calculateTotalSpent();
    notifyListeners();
    db.saveData(overallExpenseList);
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return "";
    }
  }

  DateTime startOfWeekData() {
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == "Sunday") {
        return today.subtract(Duration(days: i));
      }
    }
    return today;
  }

  Map<String, double> calculateDailyExpensesSummary() {
    Map<String, double> dailyExpensesSummary = {};
    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount.toString());
      if (dailyExpensesSummary.containsKey(date)) {
        dailyExpensesSummary[date] = dailyExpensesSummary[date]! + amount;
      } else {
        dailyExpensesSummary[date] = amount;
      }
    }
    return dailyExpensesSummary;
  }

  List<ExpenseItem> getWeeklyExpenses() {
    final startOfWeek = startOfWeekData();
    final endOfWeek = startOfWeek.add(Duration(days: 7));

    return overallExpenseList.where((expense) {
      return expense.dateTime.isAfter(startOfWeek) &&
          expense.dateTime.isBefore(endOfWeek);
    }).toList();
  }

  // For WeeklyExpensePage
  List<ExpenseItem> getWeeklyExpensesForWeek(DateTime weekStart) {
    final weekEnd = weekStart.add(Duration(days: 6)); // End of the week

    return overallExpenseList.where((expense) {
      return expense.dateTime.isAfter(weekStart.subtract(Duration(days: 1))) &&
          expense.dateTime.isBefore(weekEnd.add(Duration(days: 1)));
    }).toList();
  }

  void changeWeek(int days) {
    _currentWeekStart = _currentWeekStart.add(Duration(days: days));
    notifyListeners();
  }

  void setWeekStart(DateTime newWeekStart) {
    _currentWeekStart = newWeekStart;
    notifyListeners();
  }
// daily expense report alg se page ha jo
  Map<DateTime, double> getDailyExpensesSummary() {
    Map<DateTime, double> dailyExpenses = {};

    for (var expense in overallExpenseList) {
      DateTime dateOnly = DateTime(expense.dateTime.year, expense.dateTime.month, expense.dateTime.day);
      double amount = expense.amount;

      if (!dailyExpenses.containsKey(dateOnly)) {
        dailyExpenses[dateOnly] = 0;
      }
      dailyExpenses[dateOnly] = dailyExpenses[dateOnly]! + amount;
    }

    return dailyExpenses;
  }


  List<ExpenseItem> getExpensesForDay(DateTime day) {
    return overallExpenseList.where((expense) {
      DateTime expenseDate = DateTime(expense.dateTime.year, expense.dateTime.month, expense.dateTime.day);
      return expenseDate.isAtSameMomentAs(day);
    }).toList();
  }

//masti
  double _spendingLimit = 0.0;
  double _totalSpent = 0.0;

  double get spendingLimit => _spendingLimit;
  double get totalSpent => _totalSpent;

  void setSpendingLimit(double limit) {
    _spendingLimit = limit;

    db.saveData(overallExpenseList);
    notifyListeners();

  }

  void calculateTotalSpent() {
    _totalSpent = overallExpenseList.fold(0.0, (sum, item) => sum + item.amount);



    db.saveData(overallExpenseList);
    notifyListeners();
  }

  bool hasExceededLimit() {
    return _totalSpent > _spendingLimit;
    notifyListeners();

  }



}
