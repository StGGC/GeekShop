import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text/ui/screens/registr/registr_screen_model.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});
  @override
  Widget build(BuildContext context) {
    const InputBorder styleField = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    Widget myTextField({
      required String name,
      required IconData icon,
      required controller,
    }) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: TextFormField(
          controller: controller,
          cursorColor: Colors.teal,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(15.0),
            isCollapsed: true,
            filled: true,
            fillColor: const Color.fromARGB(255, 201, 192, 192),
            icon: Icon(icon, color: const Color.fromARGB(255, 179, 169, 169)),
            hintText: name,
            enabledBorder: styleField,
            focusedBorder: styleField,
          ),
        ),
      );
    }

    final model = context.watch<RegistrModel>();
    Widget btn() {
      return GestureDetector(
        onTap: () async =>
            await (model.isLog ? model.justLogIn() : model.justReg()).then(
          (value) => model.setPage(context: context),
        ),
        child: Container(
          padding: const EdgeInsets.all(12.0),
          margin: const EdgeInsets.only(left: 40),
          decoration: const BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
              child: Text(
            model.isLog ? 'login' : 'register',
          )),
        ),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const Align(
                alignment: Alignment.centerLeft,
                child: Text("Registration page")),
            const SizedBox(height: 20),
            myTextField(
                name: 'Email',
                icon: Icons.email_outlined,
                controller: model.emailAddress),
            myTextField(
                name: 'Password',
                icon: Icons.lock_outline,
                controller: model.password),
            btn(),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => model.setIsLog(),
              child: model.isLog
                  ? const Text('уже есть акаунт ? Войдите в акк')
                  : const Text('не зарегестрированы ? Сделайте это'),
            ),
          ],
        ),
      ),
    );
  }
}
