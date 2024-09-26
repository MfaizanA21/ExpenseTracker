import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:new_abc/data/expense_data.dart';

class SetLimitPage extends StatelessWidget {
  final TextEditingController _limitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final expenseData = Provider.of<ExpenseData>(context);
    final isOverLimit = expenseData.hasExceededLimit();
    final remainingLimit = expenseData.spendingLimit - expenseData.totalSpent;

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Weekly Spending Limit'),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 1,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildInfoCard(context, expenseData, isOverLimit, remainingLimit),
              SizedBox(height: 30),
              Text(
                'Set a new weekly spending limit:',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _limitController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount in Rs',
                  labelStyle: TextStyle(color: Colors.grey[600]),
                  filled: true,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    final newLimit = double.tryParse(_limitController.text);
                    if (newLimit != null && newLimit > 0) {
                      _handleSetLimit(context, expenseData, newLimit);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter a valid amount'),
                        ),
                      );
                    }
                  },
                  child: Text('Set Limit'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white, backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Text(
                  'The spending limit is set for a week. You will be prompted to review your limit next week.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).textTheme.bodyLarge!.color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, ExpenseData expenseData, bool isOverLimit, double remainingLimit) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Spending Details',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            _buildInfoRow(
              Icons.credit_card,
              'Limit',
              'Rs ${expenseData.spendingLimit.toStringAsFixed(2)}',
              Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 5),
            _buildInfoRow(
              Icons.money_off,
              'Used',
              'Rs ${expenseData.totalSpent.toStringAsFixed(2)}',
              Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 5),
            _buildInfoRow(
              Icons.attach_money,
              'Remaining',
              'Rs ${remainingLimit.toStringAsFixed(2)}',
              isOverLimit ? Theme.of(context).colorScheme.error : Theme.of(context).colorScheme.primary,
            ),
            SizedBox(height: 20),
            Text(
              isOverLimit
                  ? 'You have exceeded your spending limit!'
                  : 'You are within your spending limit.',
              style: TextStyle(
                fontSize: 16.0,
                color: isOverLimit ? Theme.of(context).colorScheme.error : Theme.of(context).textTheme.bodyLarge!.color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color),
        SizedBox(width: 10),
        Text(
          '$label: $value',
          style: TextStyle(
            fontSize: 16.0,
            color: color,
          ),
        ),
      ],
    );
  }

  void _handleSetLimit(BuildContext context, ExpenseData expenseData, double newLimit) {
    if (expenseData.spendingLimit > 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Update Limit'),
          content: Text('You already have a limit set. Do you want to override it with the new weekly limit of Rs $newLimit?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                expenseData.setSpendingLimit(newLimit);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Weekly spending limit updated to Rs $newLimit'),
                  ),
                );
              },
              child: Text('Override'),
            ),
          ],
        ),
      );
    } else {
      expenseData.setSpendingLimit(newLimit);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Weekly spending limit set to Rs $newLimit'),
        ),
      );
    }
  }
}
