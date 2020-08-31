import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import "package:flutter/material.dart";
import 'package:LocAll/user/repository/firebase_auth_service.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = "";

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
      ..currentUser().then((value) => this.setState(() {
            email = value.email;
          }));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100.0,
              width: 100.0,
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 80.0,
              ),
            ),
            Text(
              email,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            RaisedButton(
              onPressed: () => Auth().signOut(context),
              child: Text("Cerrar sesión"),
            ),
          ],
        ),
      ),
    );
  }
}
