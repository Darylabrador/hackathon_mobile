import 'package:flutter/material.dart';

import '../layout/custom_background_scroll.dart';
import '../widgets/resetPwd/displayed_reset_form.dart';
import '../widgets/components/custom_card.dart';

class ForgottenPwdScreen extends StatelessWidget {
  static const routeName = '/forgotten';
  const ForgottenPwdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mot de passe oublié"),
      ),
      resizeToAvoidBottomInset: false,
      body: CustomBackgroundScroll(
        ch: Center(
          child: Column(
            children: [
              SizedBox(height: mediaQuery.size.height * 0.15),
              Text(
                "Vous avez oublié votre mot de passe ?",
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                "Réinitialiser le ci-dessous.",
                style: Theme.of(context).textTheme.headline6,
              ),
              const SizedBox(height: 40),
              CustomCard(
                width: mediaQuery.size.width * 0.8,
                title: "Réinitialiser",
                cardWidget: const DisplayedResetForm(),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
