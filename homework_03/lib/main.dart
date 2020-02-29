import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:homework_03/home/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  // TODO: inicializar hive y agregar el adapter
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 2',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey[50],
      ),
      home: HomePage(),
    );
  }
}
