import 'package:finwallet/pages/HomeScreen.dart';
import 'package:finwallet/pages/Signin.dart';
import 'package:finwallet/pages/Signup.dart';
import 'package:finwallet/pages/SplashScreen.dart';
import 'package:finwallet/pages/TransactionsPage.dart';
import 'package:finwallet/widget/widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child!,
        );
      },
      title: 'Fin-Wallet',
      //initialRoute: '/signin',
      onGenerateRoute: (settings) {
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => SplashScreen());
        }
        var uri = settings.name.toString().replaceAll('/', '');
        if (uri == 'home') {
          return MaterialPageRoute(builder: (_) => HomeScreen());
        }
        if (uri == 'signin') {
          return MaterialPageRoute(builder: (_) => Signin());
        }
        if (uri == 'signup') {
          return MaterialPageRoute(builder: (_) => Signup());
        }
      },
      //scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
        buttonColor: Colors.transparent,
        scaffoldBackgroundColor: Color.fromRGBO(3, 7, 30, 1),
      ),
    );
  }
}

/*
class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
*/
class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
