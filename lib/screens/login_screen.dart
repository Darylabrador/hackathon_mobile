import 'package:flutter/material.dart';

import '../layout/custom_background_scroll.dart';
import '../widgets/auth/auth_form.dart';

import '../widgets/components/card_header.dart';
import '../widgets/components/custom_card.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "/";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: CustomBackgroundScroll(
        ch: Center(
          child: Column(
            children: [
              CardHeader.content(
                context: context,
                mediaQuery: mediaQuery,
                topSpace: SizedBox(height: mediaQuery.size.height * 0.15),
              ),
              CustomCard(
                width: mediaQuery.size.width * 0.8,
                title: "Connexion",
                cardWidget: const AuthForm(),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
