import 'package:codecamp37/constants/routes.dart';
import 'package:codecamp37/services/auth/auth_exceptions.dart';
import 'package:codecamp37/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

import 'utilities/dialog/error_dialog.dart';

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
                await AuthService.firebase()
                    .createUser(email: email, password: password);

                final user = AuthService.firebase().currentUser;
                AuthService.firebase().sendEmailVerification();
                // PushNamed Will give an automatic back icon on Appbar of VerifyEmail Page
                Navigator.of(context).pushNamed(verifyEmailRoute);
                // devtools.log(userCredential.toString());
              } on WeakPasswordAuthException {
                await showErrorDialog(context, 'Weak Password Entered');
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                    context, 'Email You Provided is Already in use');
              } on InvalidEmailAuthException {
                await showErrorDialog(context, 'Invalid Email Provided');
              } on GenericAuthException {
                await showErrorDialog(context, 'Failed to Register');
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
