import 'package:codecamp37/constants/routes.dart';
import 'package:codecamp37/utilities/show_error_dialog.dart';
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
              // FirebaseAuth:
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                /* This will automatically send the Email , when you press the "Register" Button.
                   If in case the user did not recieve the email automatically, then he/she can 
                   send email again by pressing "Send Email Verification" Button on VerifyEmail Page. */
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                // PushNamed Will give an automatic back icon on Appbar of VerifyEmail Page
                Navigator.of(context).pushNamed(verifyEmailRoute);
                // devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  // devtools.log("Weak Password");
                  await showErrorDialog(context, 'Weak Password Entered');
                } else if (e.code == 'email-already-in-use') {
                  // devtools.log("Email Already in Use");
                  await showErrorDialog(
                      context, 'Email You Provided is Already in use');
                } else if (e.code == 'invalid-email') {
                  // devtools.log("Inavalid Email");
                  await showErrorDialog(context, 'Invalid Email Provided');
                } else {
                  await showErrorDialog(context, 'Error : ${e.code}');
                }
                // It is not a FirebaseAuth Exception to catch Exceptions other than FirebaseAuth.
              } catch (e) {
                await showErrorDialog(context, e.toString());
              }
            },
            child: Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: Text("Already Registered? Login here"),
          )
        ],
      ),
    );
  }
}
