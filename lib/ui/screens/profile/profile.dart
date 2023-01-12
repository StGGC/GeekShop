import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/profile/profile_model.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

import '../../theme/theme_app.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Consumer<MyThemeNotifier>(
              builder: (context, themeModel, _) => IconButton(
                onPressed: () => themeModel.toggTheme(),
                icon: themeModel.getTheme() == MyThemeNotifier.darkTheme
                    ? const Icon(Icons.toggle_off)
                    : const Icon(Icons.toggle_on),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: _getPage(),
        ));
  }

  Widget _getPage() {
    switch (defaultTargetPlatform.name) {
      case 'windows':
        return const _DesktopBody();
      default:
        return const _MobileBody();
    }
  }
}

class _DesktopBody extends StatelessWidget {
  const _DesktopBody();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 50),
          Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'assets/imgs/Prod1.png',
                  )),
            ),
          ),
          SizedBox(height: 10),
          Text(' user is null '),
        ],
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  const _MobileBody();
  @override
  Widget build(BuildContext context) {
    final model = context.watch<ProfileModel>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text("My Profile"),
        const SizedBox(height: 10),
        Row(
          children: [
            Text("name:${model.user?.displayName}"),
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
    );
  }
}
