import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class ProfileModel extends ChangeNotifier {
  final nameController = TextEditingController();
  final adresController = TextEditingController();
  final phoneController = TextEditingController();
  final imgUrlController = TextEditingController();
  var imgUrl;
  var adres;
  var name;
  var phone;
  late User? user;
  ProfileModel() {
    user = defaultTargetPlatform.name != 'windows'
        ? FirebaseAuth.instance.currentUser
        : null;
    _cloud();
  }

  _cloud() {
    var collection = FirebaseFirestore.instance.collection('users');
    collection.snapshots().listen((querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic>? data = doc.data();
        imgUrl = data['imgUrl'];
        adres = data['adres'];
        name = data['name'];
        phone = data['phone'];
        // UserData(
        //   imgUrl: data['imgUrl'],
        //   adres: data['adres'],
        //   name: data['name'],
        //   phone: data['phone'],
        // );
      }
      notifyListeners();
    });
  }

  upDateUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({
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
