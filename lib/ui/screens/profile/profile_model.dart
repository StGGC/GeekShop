import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:text/ui/navigations/main_navigation.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class ProfileModel extends ChangeNotifier {
  late dynamic user;
  ProfileModel() {
    user = defaultTargetPlatform.name != 'windows'
        ? FirebaseAuth.instance.currentUser
        : null;
  }

  // void updateName(String name) {
  //   if (user != null) {
  //     user?.updateDisplayName(name);
  //   }
  // }

  justlogOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut().then((value) =>
        Navigator.of(context).pushNamed(MainNavigationRouteName.registrtation));
  }
}
