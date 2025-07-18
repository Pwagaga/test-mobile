import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/first_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'My Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: const Color(0xFFF5F0F6),
      ),
      debugShowCheckedModeBanner: false,
      home: const FirstScreen(),
    );
  }
}
