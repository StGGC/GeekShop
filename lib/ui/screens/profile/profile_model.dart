import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:text/ui/screens/profile/user_model.dart';

class ProfileModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final adresController = TextEditingController();
  final phoneController = TextEditingController();
  final imgUrlController = TextEditingController();
  // late String imgUrl;
  // late String adres;
  // late String name;
  // late String phone;
  late User? user;
  UserData? myuser;
  ProfileModel() {
    user = defaultTargetPlatform.name != 'windows'
        ? FirebaseAuth.instance.currentUser
        : null;
    _cloud();
  }

  _cloud() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        if (doc.id == user?.uid) {
          myuser = UserData(
            imgUrl: doc.data()['imgUrl'],
            adres: doc.data()['adres'],
            name: doc.data()['name'],
            phone: doc.data()['phone'],
          );
        }
      }
      notifyListeners();
    });
  }

  upDateUser() async {
    await FirebaseFirestore.instance.collection("users").doc(user?.uid).set({
      'name': nameController.text,
      'adres': adresController.text,
      'imgUrl': imgUrlController.text,
      'phone': phoneController.text,
    });
  }

  List<TextEditingController> textFieldControlls = <TextEditingController>[];

  justLogOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.of(context).pushNamed(MainNavigationRouteName.registrtation));
  }
}
