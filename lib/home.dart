import 'package:codecamp37/firebase_options.dart';
import 'package:codecamp37/login.dart';
import 'package:codecamp37/verifyEmail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print("Email Verified");
              } else {
                return VerifyEmail();
              }
            } else {
              return LoginView();
            }
            return Text("Done");

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
