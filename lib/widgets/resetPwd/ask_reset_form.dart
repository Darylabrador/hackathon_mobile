import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../../providers/reset_pwd_forgotten_provider.dart';

import '../components/double_button_form.dart';
import '../../services/validator_service.dart';
import '../../utils/snackbar.dart';

class AskResetForm extends StatefulWidget {
  const AskResetForm({
    Key? key,
  }) : super(key: key);

  @override
  _AskResetFormState createState() => _AskResetFormState();
}

class _AskResetFormState extends State<AskResetForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  ValidatorService validator = ValidatorService.getInstance();

  var _loading = false;

  Future<void> _submitHandler(BuildContext context) async {
    setState(() {
      _loading = true;
    });

    try {
      if (!_formKey.currentState!.validate()) {
        setState(() {
          _loading = false;
        });
        return;
      }
      
      _formKey.currentState!.save();

      final result = await Provider.of<ResetPwdForgottenProvider>(
        context,
        listen: false,
      ).getForgottenResetToken(email: emailController.text.trim());

      if (!result['success']) {
        Snackbar.showScaffold(result['message'], result['success'], context);
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
            controller: emailController,
            decoration: const InputDecoration(labelText: "Adresse email"),
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return validator.validateEmail(value);
            },
          ),
          const SizedBox(height: 30),
          DoubleButtonForm(
            cancelHanlder: () {
              Navigator.of(context).pop();
            },
            cancelText: "Retour",
            validHandler: () => _submitHandler(context),
            validText: "Valider",
          ),
        ],
      ),
    );
  }
}
