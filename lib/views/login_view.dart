import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
      appBar: AppBar(
        title: const Text("Login"),
      ),
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
            child: const Text("Login"),
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(userCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print("User not found!");
                } else if (e.code == 'wrong-password') {
                  print('Wrong password');
                } else {
                  print('Something wrong happened!');
                }
              }
            },
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                '/register',
                (route) => false,
              );
            },
            child: const Text("Not registered yet? Click here!"),
          )
        ],
      ),
    );
  }
}
