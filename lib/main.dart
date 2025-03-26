import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';
import 'package:todo_app/pages/home_page.dart';

void main() async {
  //I N I T   T H E   H I V E
  await Hive.initFlutter();

  //O P E N   A   B O X
  var box = await Hive.openBox('mybox');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // theme: ThemeData(primarySwatch: Colors.yellow),
    );
  }
}
