import 'package:flutter/material.dart';
import 'package:marketplace/marketplace/ui/screens/home.dart';
import 'package:marketplace/user/ui/screens/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool auth = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => auth ? Home() : SignIn(),
        '/home': (context) => Home(),
      },
    );
  }
}
