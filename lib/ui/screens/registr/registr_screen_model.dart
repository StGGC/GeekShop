import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../navigations/main_navigation.dart';

class RegistrModel extends ChangeNotifier {
  TextEditingController emailAddress = TextEditingController();
  TextEditingController password = TextEditingController();

  late final User? user;
  var isLog = false;

  void setIsLog() {
    isLog = !isLog;
    notifyListeners();
  }

  Future<void> justReg({
    required String emailAddress,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      user = FirebaseAuth.instance.currentUser;
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
      {required String emailAddress,
      required String password,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password)
          .then((value) {
        user = FirebaseAuth.instance.currentUser;
        user != null
            ? Navigator.of(context).pushNamed(
                MainNavigationRouteName.main,
              )
            : print('user null');
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('$e --- неведомая ');
      }
    }
  }
}
