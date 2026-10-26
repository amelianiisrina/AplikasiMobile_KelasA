import 'package:flutter/material.dart';
import 'main_screen.dart';
import 'add_transaction_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense Tracker Final',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/': (context) {
          final email =
              ModalRoute.of(context)?.settings.arguments as String? ?? '';

          return MainScreen(email: email);
        },
        '/add': (context) => const AddTransactionScreen(),
      },
    );
  }
}