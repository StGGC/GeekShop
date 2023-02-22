import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class ProfileModel extends ChangeNotifier {
  final nameController = TextEditingController();
  late User? user;
  ProfileModel() {
    user = defaultTargetPlatform.name != 'windows'
        ? FirebaseAuth.instance.currentUser
        : null;
  }

  upDateUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
      'name': nameController.text,
    });
  }

  List<TextEditingController> textFieldControlls = <TextEditingController>[];

  justLogOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.of(context).pushNamed(MainNavigationRouteName.registrtation));
  }
}
