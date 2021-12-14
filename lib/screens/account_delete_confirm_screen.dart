import 'package:flutter/material.dart';
import '../providers/account_provider.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';

import '../widgets/components/custom_text_form_field.dart';
import '../widgets/components/double_button_form.dart';
import '../layout/custom_background_scroll.dart';

import '../utils/snackbar.dart';
import '../services/validator_service.dart';

class AccountDeleteConfirmScreen extends StatefulWidget {
  static const routeName = "/confirm-delete";
  const AccountDeleteConfirmScreen({Key? key}) : super(key: key);

  @override
  _AccountDeleteConfirmScreenState createState() =>
      _AccountDeleteConfirmScreenState();
}

class _AccountDeleteConfirmScreenState
    extends State<AccountDeleteConfirmScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  Future<void> _submit(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    try {
      Map<String, dynamic> repData = await Provider.of<AccountProvider>(
        context,
        listen: false,
      ).deleteAccount(
        password: _passwordController.text.trim(),
        passwordConfirm: _passwordConfirmController.text.trim(),
      );
      Snackbar.showScaffold(repData['message'], repData["success"], context);
      if (repData['success']) {
        Provider.of<AuthProvider>(context).logout();
        Navigator.of(context).popAndPushNamed(LoginScreen.routeName);
      }
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Suppression de compte"),
      ),
      body: CustomBackgroundScroll(
        ch: Center(
          child: SizedBox(
            width: mediaQuery.size.width * 0.9,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: mediaQuery.size.height * 0.25),
                  const Text(
                    "Vous nous quittez déjà ?",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Saissisez votre mot de passe pour confirmer la suppression",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  CustomTextFormField(
                      labelText: "Mot de passe",
                      controller: _passwordController,
                      obscureText: true,
                      validator: (value) =>
                          ValidatorService.validateField(value)),
                  const SizedBox(height: 10),
                  CustomTextFormField(
                      labelText: "Confirmation mot de passe",
                      controller: _passwordConfirmController,
                      obscureText: true,
                      validator: (value) =>
                          ValidatorService.validateField(value)),
                  const SizedBox(height: 20),
                  DoubleButtonForm(
                    cancelHanlder: () => Navigator.of(context).pop(),
                    cancelText: "Annuler",
                    validHandler: () => _submit(context),
                    validText: "Valider",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
