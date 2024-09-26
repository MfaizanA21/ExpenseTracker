import 'package:flutter/material.dart';
import 'package:new_abc/help.dart';
import '../daily_expense.dart';
import '../set_limit_page.dart';
import '../weekly_expense.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            color: Colors.grey[650],
            padding: EdgeInsets.all(16),
            child: DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Image.asset('assets/qwerty.png', fit: BoxFit.cover),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Expense Tracker',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Drawer items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [

                ListTile(
                  leading: Icon(Icons.date_range, color: Colors.grey[700]),
                  title: Text('Weekly Expenses', style: TextStyle(color: Colors.grey[700])),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WeeklyExpensePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.date_range, color: Colors.grey[700]),
                  title: Text('Daily Expenses', style: TextStyle(color: Colors.grey[700])),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DailyExpensePage()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.keyboard_control, color: Colors.grey[700]),
                  title: Text('Set Limits', style: TextStyle(color: Colors.grey[700])),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SetLimitPage()),
                    );
                  },
                ),

                // Add more items as needed
              ],
            ),
          ),
          // Trademark at the bottom
          Container(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'GujjarCodes 😉©',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
