import 'package:flutter/material.dart';
import 'package:projext/screens/login.dart';

void main() => runApp(
      const MyApp(),
    );

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}

//github repo inspiration
//https://github.com/basirkhan1995/flutter_sqlite_crud.git