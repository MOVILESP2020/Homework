import 'package:flutter/material.dart';
import 'package:homework_01/screens/home.dart';
import 'package:homework_01/screens/pagethree.dart';
import 'package:homework_01/screens/pagetwo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Homework One',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tarea 1'),
    );
  }
}


