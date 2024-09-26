import 'package:flutter/material.dart';
import 'package:new_abc/drawer/drawer.dart';
import 'package:new_abc/set_limit_page.dart';
import 'package:new_abc/theme/themesettings.dart';
import 'package:new_abc/weekly_expense.dart';
import 'daily_expense.dart';
import 'home_page.dart';

class HomePagee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Expense Tracker", style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.grey[500],
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ThemeSettingsPage()),
              );
            },
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black38, Colors.black54],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Let\'s Manage Expenses Together 😉',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  FeatureTile(
                    icon: Icons.add,
                    title: 'Create New Expense',
                    description: 'Add new expenses',
                    color: colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                  FeatureTile(
                    icon: Icons.insert_chart,
                    title: 'Weekly Expense Report',
                    description: 'Weekly Expenses with Graph',
                    color: colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                  ),
                  FeatureTile(
                    icon: Icons.bar_chart,
                    title: 'Weekly Expenses',
                    description: 'Detailed Expense Report per Week',
                    color: colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeeklyExpensePage()),
                      );
                    },
                  ),
                  FeatureTile(
                    icon: Icons.today,
                    title: 'Daily Expense',
                    description: 'Track daily spending by Dates',
                    color: colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DailyExpensePage()),
                      );
                    },
                  ),
                  FeatureTile(
                    icon: Icons.warning_amber,
                    title: 'Set Limit',
                    description: 'Set your spending limits',
                    color: colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetLimitPage()),
                      );
                    },
                  ),


                  FeatureTile(
                    icon: Icons.settings_suggest_sharp,
                    title: 'Change Theme',
                    description: 'Wanna Change Theme ..',
                    color: colorScheme.primary,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ThemeSettingsPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final VoidCallback onTap;

  const FeatureTile({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(15),

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: color),
            SizedBox(height: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
