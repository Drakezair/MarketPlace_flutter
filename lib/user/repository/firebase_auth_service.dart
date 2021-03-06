import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<bool> signUpWithEmailAndPassword(
      {@required email,
      @required password,
      @required name,
      @required phone,
      @required region}) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ))
          .user;
      FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(user.uid)
          .set({"name": name, "region": region, "phone": phone});
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

  recoverPassword({@required email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (Exception) {
      return false;
    }
  }

  signOut(BuildContext context) async {
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/auth/sign_in');
  }

  updateProfile({
    @required uuid,
    @required name,
    @required phone,
    @required region,
  }) async {
    try {
      await FirebaseDatabase.instance
          .reference()
          .child("users")
          .child(uuid)
          .update({"name": name, "phone": phone, "region": region});
      return true;
    } catch (Exception) {
      return false;
    }
  }
}
