import 'package:flutter/material.dart';
import '../layout/custom_background.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomBackground(
        ch: Center(
          child: Text("login page"),
        ),
      ),
    );
  }
}
