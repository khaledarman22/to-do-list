import 'package:flutter/material.dart';
import 'package:tasksblok/counter_screen/counter_screen.dart';
import 'package:tasksblok/screens/home/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NavHomeScreen(),
    );
  }
}
