import 'package:codecamp37/login.dart';
import 'package:codecamp37/notes.dart';
import 'package:codecamp37/services/auth/auth_service.dart';
import 'package:codecamp37/verifyEmail.dart';
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
      future: AuthService.firebase().Initialze(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return VerifyEmail();
              }
            } else {
              return LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
