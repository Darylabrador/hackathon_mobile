import 'package:flutter/material.dart';
import 'package:hackathon_mobile_app/providers/account_provider.dart';
import 'package:provider/provider.dart';

import '../../components/custom_text_form_field.dart';
import '../../components/double_button_form.dart';

import '../../../utils/snackbar.dart';
import '../../../services/validator_service.dart';

class AccountPasswordForm extends StatefulWidget {
  const AccountPasswordForm({Key? key}) : super(key: key);

  @override
  _AccountPasswordFormState createState() => _AccountPasswordFormState();
}

class _AccountPasswordFormState extends State<AccountPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  var _loading = false;
  var _isHiddenPassword = true;

  void _showPassword() {
    setState(() {
      _isHiddenPassword = !_isHiddenPassword;
    });
  }

  void _resetForm() {
    _formKey.currentState!.reset();
    _oldPasswordController.text = "";
    _passwordController.text = "";
    _passwordConfirmController.text = "";
  }

  Future<void> _submitHandler(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    if (!_formKey.currentState!.validate()) {
      setState(() {
        _loading = false;
      });

      return;
    }
    _formKey.currentState!.save();

    try {
      Map<String, dynamic> repData = await Provider.of<AccountProvider>(
        context,
        listen: false,
      ).updatePassword(
        oldPassword: _oldPasswordController.text.trim(),
        password: _passwordController.text.trim(),
        passwordConfirm: _passwordConfirmController.text.trim(),
      );
      Snackbar.showScaffold(repData['message'], repData["success"], context);
      if (repData['success']) {
        _resetForm();
      }
    } catch (e) {
      Snackbar.showScaffold(e.toString(), false, context);
    }
    setState(() {
      _loading = false;
    });
  }

  Widget buildButtonorLoader(BuildContext context) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return DoubleButtonForm(
      cancelHanlder: _resetForm,
      cancelText: "Annuler",
      validHandler: () => _submitHandler(context),
      validText: "Valider",
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Form(
      key: _formKey,
      child: SizedBox(
        width: mediaQuery.size.width * 0.9,
        child: Column(
          children: [
            const SizedBox(height: 20),
            CustomTextFormField(
              labelText: "Ancien mot de passe",
              controller: _oldPasswordController,
              obscureText: _isHiddenPassword,
              validator: (value) => ValidatorService.validateField(value),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Nouveau mot de passe",
              controller: _passwordController,
              obscureText: _isHiddenPassword,
              validator: (value) => ValidatorService.validatePassword(value),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Confirmation mot de passe",
              controller: _passwordConfirmController,
              obscureText: _isHiddenPassword,
              validator: (value) => ValidatorService.validatePassword(value),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: _showPassword,
              child: Text(
                _isHiddenPassword
                    ? "Afficher le mot de passe"
                    : "Cacher le mot de passe",
              ),
            ),
            const SizedBox(height: 20),
            buildButtonorLoader(context),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
