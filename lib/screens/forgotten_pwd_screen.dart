import 'package:flutter/material.dart';

import '../layout/custom_background_scroll.dart';
import '../widgets/resetPwd/displayed_reset_form.dart';

import '../widgets/components/card_header.dart';
import '../widgets/components/custom_card.dart';

class ForgottenPwdScreen extends StatelessWidget {
  static const routeName = '/forgotten';
  const ForgottenPwdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: CustomBackgroundScroll(
        ch: Center(
          child: Column(
            children: [
              CardHeader.content(
                context: context,
                mediaQuery: mediaQuery,
                topSpace: SizedBox(height: mediaQuery.size.height * 0.15),
              ),
              const CustomCard(
                width: 400.0,
                title: "Mot de passe oublié",
                cardWidget: DisplayedResetForm(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
