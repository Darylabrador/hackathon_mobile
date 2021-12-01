import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/reset_pwd_forgotten_provider.dart';
import '../../screens/login_screen.dart';

import '../components/double_button_form.dart';
import '../../utils/snackbar.dart';
import '../../services/validator_service.dart';

class ActResetForm extends StatefulWidget {
  const ActResetForm({Key? key}) : super(key: key);

  @override
  _ActResetFormState createState() => _ActResetFormState();
}

class _ActResetFormState extends State<ActResetForm> {
  final _formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  Future<void> _submitHandler(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      final result = await Provider.of<ResetPwdForgottenProvider>(
        context,
        listen: false,
      ).updateForgottenPassword(
        password: passwordController.text.trim(),
        passwordConfirm: passwordConfirmController.text.trim(),
      );

      Snackar.showScaffold(result["message"], result["success"], context);

      if (result["success"]) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }

      _formKey.currentState!.reset();
    } catch (e) {
      Snackar.showScaffold(e.toString(), false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: "Nouveau mot de passe",
            ),
            textInputAction: TextInputAction.next,
            obscureText: true,
            validator: (value) {
              return ValidatorService.validatePassword(value);
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            autocorrect: false,
            controller: passwordConfirmController,
            decoration: const InputDecoration(
              labelText: "Confirmation du mot de passe",
            ),
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              return ValidatorService.validatePassword(value);
            },
          ),
          const SizedBox(height: 30),
          DoubleButtonForm(
            cancelHanlder: () {
              Provider.of<ResetPwdForgottenProvider>(
                context,
                listen: false,
              ).handleSwitchResetForm();
            },
            cancelText: "Annuler",
            validHandler: () => _submitHandler(context),
            validText: "Valider",
          )
        ],
      ),
    );
  }
}
