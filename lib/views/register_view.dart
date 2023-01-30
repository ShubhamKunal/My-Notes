import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mynotes/constants/routes.dart';
import 'dart:developer' as devtools;

import 'package:mynotes/utilities/show_error_dialog.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  State<RegistrationView> createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    // TODO: implement initState
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(hintText: "Email"),
            controller: _email,
            keyboardType: TextInputType.emailAddress,
          ),
          TextField(
            decoration: const InputDecoration(hintText: "Password"),
            enableSuggestions: false,
            autocorrect: false,
            controller: _password,
            obscureText: true,
          ),
          TextButton(
            child: const Text("Register"),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  devtools.log("Password is weak!");
                  showErrorDialog(context, "Password is too weak!");
                } else if (e.code == 'email-already-in-use') {
                  devtools.log("Use another email!");
                  showErrorDialog(context, "Email is already in use!");
                } else if (e.code == 'invalid-email') {
                  devtools.log("Invalid email entered!");
                  showErrorDialog(context, "Invalid Email!");
                } else {
                  devtools.log("Something wrong happened!");
                  showErrorDialog(context, "Something went wrong!");
                }
              } catch (e) {
                showErrorDialog(context, "Something went wrong!");
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Already registered? Go to login!"),
          )
        ],
      ),
    );
  }
}
