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
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  var _loading = false;

  Future<void> _submitHandler(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      final result = await Provider.of<ResetPwdForgottenProvider>(
        context,
        listen: false,
      ).updateForgottenPassword(
        code: _codeController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirm: _passwordConfirmController.text.trim(),
      );

      Snackbar.showScaffold(result["message"], result["success"], context);

      if (result["success"]) {
        Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
      }
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }

    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            controller: _codeController,
            decoration: const InputDecoration(
              labelText: "Code de validation",
            ),
            textInputAction: TextInputAction.done,
            validator: (value) {
              return ValidatorService.validateField(value);
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            autocorrect: false,
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: "Nouveau mot de passe",
            ),
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              return ValidatorService.validatePassword(value);
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            autocorrect: false,
            controller: _passwordConfirmController,
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
