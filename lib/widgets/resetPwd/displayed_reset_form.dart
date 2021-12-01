import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './ask_reset_form.dart';
import './act_reset_form.dart';

import '../../providers/reset_pwd_forgotten_provider.dart';

class DisplayedResetForm extends StatelessWidget {
  const DisplayedResetForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _isResettingAskForm =
        Provider.of<ResetPwdForgottenProvider>(context).isResettingAskForm;
    if (_isResettingAskForm) {
      return const AskResetForm();
    } else {
      return const ActResetForm();
    }
  }
}
