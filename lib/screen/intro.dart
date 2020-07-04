import 'package:flutter/material.dart';
import 'package:golang/provider/pref.dart';
import 'package:golang/screen/home.dart';
import 'package:golang/screen/signin.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      stick();
    });
  }

  void stick() async {
    var isLogged = await PrefProvider.instance.get("token");
    if (isLogged != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePageScreen(),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => SignInScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Image.network(
          'https://www.techsignin.com/wp-content/uploads/2018/10/microsoft-hoan-thanh-thuong-vu-github.png'),
    );
  }
}
