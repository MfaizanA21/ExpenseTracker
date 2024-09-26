import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_abc/splashscreen/splash_screen.dart';
import 'package:new_abc/weekly_expense.dart';
import 'package:provider/provider.dart';
import 'package:new_abc/home_page.dart';
import 'package:new_abc/theme/theme_notifier.dart';
import 'package:new_abc/theme/themes.dart';
import 'package:new_abc/data/expense_data.dart';

import 'help.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ExpenseData()..prepareData()),
        ChangeNotifierProvider(create: (context) => ThemeNotifier()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: themeNotifier.currentThemeMode,
            theme: lightTheme,
            darkTheme: darkTheme,
            home:SplashScreen(),
          );
        },
      ),
    );
  }
}
