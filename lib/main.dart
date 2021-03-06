import 'package:LocAll/user/ui/screens/forgot.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:LocAll/marketplace/ui/screens/home_app.dart';
import 'package:LocAll/user/ui/screens/sign_in.dart';
import 'package:LocAll/user/ui/screens/sign_up.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Montserrat',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => RoutePage(),
        '/auth/sign_in': (context) => SignIn(),
        '/auth/sign_up': (context) => SignUp(),
        '/auth/forgot': (context) => Forgot(),
        '/home': (context) => HomeApp(),
      },
    );
  }
}

class RoutePage extends StatefulWidget {
  @override
  _RoutePageState createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((firebaseUser) {
      if (firebaseUser != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        Navigator.pushReplacementNamed(context, '/auth/sign_in');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF00bcd4),
      child: Center(
        child: Image.asset(
          "assets/images/Icono_Locall.png",
          height: 200.0,
        ),
      ),
    );
  }
}
