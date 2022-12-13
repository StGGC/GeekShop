import 'package:flutter/material.dart';

class CircularLoad extends StatelessWidget {
  const CircularLoad({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
          child: CircularProgressIndicator(
        color: Colors.red,
        strokeWidth: 3,
      )),
    );
  }
}
