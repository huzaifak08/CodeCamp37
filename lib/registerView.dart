import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: FutureBuilder(
        // Not TO Initialize Firebase for every button , we use FutureBuilder:
        // In future write The App Initializer:

        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),

        // In (builder) write the rest of the code.

        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            // This is the Loading Screen: It has 4 Cases:
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: "Enter your Email",
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextField(
                    controller: _password,
                    decoration:
                        InputDecoration(hintText: "Enter Your Passoward"),
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                  ),
                  TextButton(
                    onPressed: () async {
                      // FirebaseAuth:
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final userCredential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        print(userCredential);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print("Weak Password");
                        } else if (e.code == 'email-already-in-use') {
                          print("Email Already in Use");
                        } else if (e.code == 'invalid-email') {
                          print("Inavalid Email");
                        }
                      }
                    },
                    child: Text("Register"),
                  )
                ],
              );
            // Default is Compulsory:
            default:
              return Text("Loading...");
          }
        },
      ),
    );
  }
}
