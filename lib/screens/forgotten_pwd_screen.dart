import 'package:flutter/material.dart';
import '../layout/custom_background.dart';

class ForgottenPwdScreen extends StatelessWidget {
  static const routeName = '/forgotten';
  const ForgottenPwdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomBackground(
        ch: Center(
          child: Text("forgotten page"),
        ),
      ),
    );
  }
}
