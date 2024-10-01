import 'package:flutter/material.dart';
import 'package:scanner/functions.dart';
import 'package:scanner/screens/my_main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: color_60,
        colorScheme: ColorScheme.fromSeed(seedColor: color_60),
        useMaterial3: true,
      ),
      home: const MyMainPage(),
    );
  }
}
