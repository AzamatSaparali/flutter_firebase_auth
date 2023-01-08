import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisteView extends StatefulWidget {
  const RegisteView({super.key});

  @override
  State<RegisteView> createState() => _RegisteViewState();
}

class _RegisteViewState extends State<RegisteView> {
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
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Enter email',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'Enter password',
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final UserCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(UserCredential);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'wrong-password') {
                  print('You have typed a wrong password');
                } else if (e.code == 'weak-password') {
                  print('You have typed a WEAK password');
                } else if (e.code == 'email-already-in-use') {
                  print('This email is already exists in Database');
                } else if (e.code == 'invalid-email') {
                  print('This not an Email');
                } else {
                  print('Something else happened');
                  print(e.code);
                }
                ;
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/login/', (route) => false);
            },
            child: Text('Already registered? Login here!'),
          )
        ],
      ),
    );
  }
}
