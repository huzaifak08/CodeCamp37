import 'package:codecamp37/constants/routes.dart';
import 'package:codecamp37/services/auth/auth_exceptions.dart';
import 'package:codecamp37/services/auth/auth_service.dart';
import 'package:codecamp37/utilities/show_error_dialog.dart';
import 'package:flutter/material.dart';

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
                await AuthService.firebase()
                    .logIn(email: email, password: password);

                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  // Email is verified then move to Main UI(Home).
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                } else {
                  // Email is not Verified so do not move to (Home).
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      verifyEmailRoute, (route) => false);
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(context, 'User Not Found');
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Wrong Password Entered');
              } on GenericAuthException {
                await showErrorDialog(context, 'Authentication Error');
              }
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
