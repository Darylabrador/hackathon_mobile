import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/auth_provider.dart';

import '../../screens/dashboard_screen.dart';
import '../../screens/forgotten_pwd_screen.dart';
import '../../services/validator_service.dart';
import '../../utils/snackbar.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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

      final result = await Provider.of<AuthProvider>(
        context,
        listen: false,
      ).login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      Snackbar.showScaffold(result['message'], result['success'], context);

      if (result['success']) {
        _formKey.currentState!.reset();
        Navigator.of(context).pushReplacementNamed(DashboardScreen.routeName);
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

    return Column(
      children: [
        SizedBox(
          width: 200,
          child: ElevatedButton(
            child: const Text("Se connecter"),
            onPressed: () => _submitHandler(context),
          ),
        ),
        const SizedBox(height: 5),
        TextButton(
          onPressed: () {
            Navigator.of(context).pushNamed(ForgottenPwdScreen.routeName);
          },
          child: const Text("Mot de passe oublié ?"),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            controller: emailController,
            decoration: const InputDecoration(labelText: "Adresse email"),
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              return validator.validateEmail(value);
            },
          ),
          const SizedBox(height: 5),
          TextFormField(
            autocorrect: false,
            controller: passwordController,
            decoration: const InputDecoration(labelText: "Mot de passe"),
            textInputAction: TextInputAction.done,
            obscureText: true,
            validator: (value) {
              return validator.validatePassword(value);
            },
          ),
          const SizedBox(height: 40),
          buildButtonorLoader(context)
        ],
      ),
    );
  }
}
