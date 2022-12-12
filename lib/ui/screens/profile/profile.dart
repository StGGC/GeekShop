import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/profile/profile_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text("My Profile"),
            const SizedBox(height: 10),
            Row(
              children: [
                Text("name:${model.user?.displayName}"),
                // GestureDetector(
                //   onTap: () => model.updateName('Jake'),
                //   child: const Text('upDataName'),
                // )
              ],
            ),
            const SizedBox(height: 10),
            Text("UID:${model.user?.uid}"),
            const SizedBox(height: 12),
            GestureDetector(
              child: Container(
                padding: const EdgeInsets.all(7.0),
                margin: const EdgeInsets.only(left: 40),
                decoration: const BoxDecoration(
                    color: Colors.teal,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(child: Text('Log Out')),
              ),
              onTap: () {
                model.justlogOut(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
