import 'package:codecamp37/constants/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify Email")),
      body: Column(
        children: [
          Text("We've Send you an Email Verication. Please Verify It."),
          Text("If you not Recieved Email Then Press the Butoon Below."),
          Text("Verify your Email Address"),
          TextButton(
            onPressed: () async {
              var user = FirebaseAuth.instance.currentUser;
              print(user);
              await user?.sendEmailVerification();
              print("I sent the call");
            },
            child: Text("Send Email Verification"),
          ),

          // Button to move back to Register page.
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(registerRoute, (route) => false);
            },
            child: Text('Restart'),
          )
        ],
      ),
    );
  }
}
