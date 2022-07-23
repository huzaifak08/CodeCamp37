import 'package:codecamp37/constants/routes.dart';
import 'package:codecamp37/home.dart';
import 'package:codecamp37/login.dart';
import 'package:codecamp37/notes.dart';
import 'package:codecamp37/registerView.dart';
import 'package:codecamp37/verifyEmail.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  // Initialze Firebase One Time for Whole Project:

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      home: const LoginView(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView()
      },
    );
  }
}
