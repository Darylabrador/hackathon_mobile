import 'package:flutter/material.dart';
import '../layout/custom_background.dart';

class SplashScreen extends StatelessWidget {
  static const routeName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CustomBackground();
  }
}
