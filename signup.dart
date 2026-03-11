import 'package:flutter/material.dart';

import 'views/signup.dart';

void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: SignUpPage()),
);

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignupScreen();
  }
}
