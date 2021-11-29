import 'package:flutter/material.dart';

import '../layout/custom_background_scroll.dart';
import '../widgets/auth/auth_form.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/login";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundScroll(
        ch: Center(
          child: Column(
            children: const [
              Text("test1"),
              AuthForm()
            ],
          ),
        ),
      ),
    );
  }
}
