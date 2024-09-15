import 'package:flutter/material.dart';
import 'package:meuapp/view/home_screen.dart';
import 'package:meuapp/view/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple),
              foregroundColor: MaterialStatePropertyAll(Colors.white)),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          background: Colors.grey[100],
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
