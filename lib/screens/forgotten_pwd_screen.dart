import 'package:flutter/material.dart';

import '../layout/custom_background_scroll.dart';
import '../widgets/resetPwd/displayed_reset_form.dart';

class ForgottenPwdScreen extends StatelessWidget {
  static const routeName = '/forgotten';
  const ForgottenPwdScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackgroundScroll(
        ch: Center(
          child: Column(
            children: const [
              Text("test1"),
              DisplayedResetForm(),
            ],
          ),
        ),
      ),
    );
  }
}
