import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpWithEmailAndPassword(
      {@required email, @required password}) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      print(user);
      return true;
    } catch (Exception) {
      return false;
    }
  }

  Future<bool> signInWithEmailAndPassword(
      {@required email, @required password}) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      return true;
    } catch (Exception) {
      return false;
    }
  }

  signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/auth/sign_in');
  }
}
