import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_screen.dart';
import 'screens/add_transaction_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProjectAppmob());
}

class ProjectAppmob extends StatelessWidget {
  const ProjectAppmob({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Appmob',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE53935),
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/add') {
          final args = settings.arguments as Map<String, dynamic>?;

          if (args == null || args['userId'] is! int) {
            return MaterialPageRoute(
              builder: (context) => const Scaffold(
                body: Center(
                  child: Text('Data pengguna tidak valid.'),
                ),
              ),
            );
          }

          return MaterialPageRoute(
            builder: (context) => AddTransactionScreen(
              userId: args['userId'] as int,
              initialType: args['type'] as String?,
            ),
          );
        }

        if (settings.name == '/') {
          final args = settings.arguments;

          if (args is! Map<String, dynamic> ||
              args['user'] == null) {
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );
          }

          return MaterialPageRoute(
            builder: (context) => MainScreen(
              user: args['user'],
            ),
          );
        }

        return null;
      },
    );
  }
}