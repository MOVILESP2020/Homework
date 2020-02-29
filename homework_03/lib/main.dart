import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:homework_03/home/home.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/todo_remainder.dart';

void main() async {
  // Inicializar antes de crear app
  WidgetsFlutterBinding.ensureInitialized();
  // Acceso al local storage
  final _localStorage = await path_provider.getApplicationDocumentsDirectory();
  // Inicializar hive
  Hive.init(_localStorage.path);
  // Registrar adapter
  Hive.registerAdapter(TodoRemainderAdapter());
  // Abrir la caja
  await Hive.openBox("reminders");


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tarea 3',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.grey[50],
      ),
      home: HomePage(),
    );
  }
}
