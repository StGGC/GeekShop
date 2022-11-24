import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileModel extends ChangeNotifier {
  justlogOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
