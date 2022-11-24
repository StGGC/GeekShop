import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrModel extends ChangeNotifier {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();

  final user = FirebaseAuth.instance.currentUser;
  var isLog = false;
  void setIsLog() {
    isLog = !isLog;
    notifyListeners();
  }

  Future<void> justReg(
      {required String emailAddress, required String password}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      await user?.updateDisplayName(name.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print('qweqwewew');
    }
  }

  Future<void> justLogIn(
      {required String emailAddress, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
}
