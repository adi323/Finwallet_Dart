import 'dart:async';

import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:finwallet/helper/authSave.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool loggedIn = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
    Timer(Duration(milliseconds: 2500), () {
      loggedIn
          ? Navigator.of(context).pushReplacementNamed('/home')
          : Navigator.of(context).pushReplacementNamed('/signup');
    });
  }

  getStatus() async {
    await authSave.getLoggedinStatus().then((value) => loggedIn = value!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Vx.white,
        width: context.screenWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('./lib/assets/splash.gif', width: 150, height: 150),
            SizedBox(
              height: 25,
            ),
            Text(
              "Splash Screen",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            )
          ],
        ),
      ),
    );
  }
}
