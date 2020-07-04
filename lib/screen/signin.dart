import 'package:flutter/material.dart';
import 'package:golang/widget/sign_in.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text("Sign in"),
      ),
      body: SignIn(),
    );
  }
}
