import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final TextEditingController? controller;
  const MyTextField(
      {super.key, this.hintText = '', this.icon, this.controller});
  @override
  Widget build(BuildContext context) {
    const InputBorder styleField = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(style: BorderStyle.none),
    );
    return TextField(
      controller: controller,
      scrollPadding: EdgeInsets.zero,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 201, 192, 192),
        // fillColor: Colors.white,
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 18),
        prefixIcon: Icon(icon, size: 18),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: styleField,
        focusedBorder: styleField,
      ),
    );
  }
}
