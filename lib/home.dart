import 'package:codecamp37/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        title: Text("Home Page"),
      ),
      body: FutureBuilder(
        // Not TO Initialize Firebase for every button , we use FutureBuilder:
        // In future write The App Initializer:

        future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform),

        // In (builder) write the rest of the code.

        builder: (context, snapshot) {
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
                decoration: InputDecoration(hintText: "Enter Your Passoward"),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
              TextButton(
                onPressed: () async {
                  // Initialize Firebase:

                  // FirebaseAuth:
                  final email = _email.text;
                  final password = _password.text;
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                    email: email,
                    password: password,
                  );
                  print(userCredential);
                },
                child: Text("Register"),
              )
            ],
          );
        },
      ),
    );
  }
}
