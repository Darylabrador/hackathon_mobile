import 'package:flutter/material.dart';
import '../widgets/custom_background.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Widget buildLoginScreen() {
    return const Center(
      child: Text("Titre et formulaire de la page de connexion"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomBackground(buildLoginScreen()),
    );
  }
}
