import 'package:codecamp37/home.dart';
import 'package:codecamp37/login.dart';
import 'package:codecamp37/registerView.dart';
import 'package:flutter/material.dart';

void main() {
  // Initialze Firebase One Time for Whole Project:

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}
