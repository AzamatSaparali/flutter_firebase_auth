import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Email verification'),
      ),
      body: Column(
        children: [
          Text('Please veirfy your email'),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;

              try {
                await user?.sendEmailVerification();
              } catch (e) {
                print(e);
              }
            },
            child: Text('Send email verification'),
          )
        ],
      ),
    );
  }
}
