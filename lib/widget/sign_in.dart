import 'package:flutter/material.dart';
import 'package:golang/api/base.dart';
import 'package:golang/provider/pref.dart';
import 'package:golang/screen/home.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            cursorColor: Colors.grey[900],
            controller: _emailController,
            decoration: InputDecoration(
              labelText: "Email",
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              labelText: "Password",
              labelStyle: TextStyle(color: Colors.black),
              fillColor: Colors.black,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 2.0),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            width: 250,
            height: 45,
            child: RaisedButton(
              color: Colors.grey[900],
              onPressed: doSignIn,
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void doSignIn() {
    var email = _emailController.text;
    var pass = _passController.text;

    GithubBaseApi().signIn(email, pass).then((user) async {
      await PrefProvider.instance.set("token", user.token);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageScreen(),
        ),
      );
    });
  }
}
