import 'package:codecamp37/constants/routes.dart';
import 'package:codecamp37/firebase_options.dart';
import 'package:codecamp37/utilities/show_error_dialog.dart';
import 'package:codecamp37/verifyEmail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: Text("Login view"),
      ),
      body: Column(
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

              try {
                // In Case of Sign In:

                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );

                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  // Email is verified then move to Main UI(Home).
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  // Email is not Verified so do not move to (Home).
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, (route) => false);
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  await showErrorDialog(context, 'User Not Found');
                  // devtools.log("USer Not Found");
                } else if (e.code == 'wrong-password') {
                  await showErrorDialog(context, 'Wrong Password Entered');
                  // devtools.log("Weak Password");
                } else {
                  await showErrorDialog(context, 'Error : ${e.code}');
                }
                // else {
                //   print(e.code);
                // }
                // print(e.code);

                // It is not a FirebaseAuth Exception, Its just the normal one.
              } catch (e) {
                await showErrorDialog(context, e.toString());
              }
              /* 
                           In Case If you dont Know the Error:
    
                           catch (e) {
                           print("Some Thing Wrong Happened..");
                           print(e.runtimeType);
                           print(e);
                         } */
            },
            child: Text("Login"),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: Text("Not Registered Yet? Register here"))
        ],
      ),
    );
  }
}
