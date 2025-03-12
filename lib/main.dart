import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todo_app/pages/homepage.dart';

void main() async {
  await Hive.initFlutter("hive_boxes");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'todo-app',
      theme: ThemeData(
       
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple,),
      ),
     home: Homepage(),
    );
  }
}

