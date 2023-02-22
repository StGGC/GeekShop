import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../navigations/main_navigation.dart';

class RegistrModel extends ChangeNotifier {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();
  late final FirebaseAuth _auth;

  RegistrModel() {
    _auth = FirebaseAuth.instance;
  }
  var isLog = false;
  void setIsLog() {
    isLog = !isLog;
    notifyListeners();
  }

  void setPage({context}) {
    if (_auth.currentUser != null) {
      Navigator.of(context).pushNamed(MainNavigationRouteName.main);
    }
  }

  Future<void> justReg() async {
    await _auth.createUserWithEmailAndPassword(
      email: emailAddress.text,
      password: password.text,
    );
  }

  Future<void> justLogIn() async {
    await _auth.signInWithEmailAndPassword(
      email: emailAddress.text,
      password: password.text,
    );
  }
}
