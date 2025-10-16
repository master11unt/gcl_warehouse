import 'package:flutter/material.dart';
import 'package:gcl_warehouse/pages/home_page.dart';
import 'package:gcl_warehouse/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GCL Warehouse',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 30, 56, 136)),
      ),
      home: LoginPage(),
    );
  }
}