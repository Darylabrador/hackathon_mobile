import 'package:flutter/material.dart';
import '../layout/custom_background.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomBackground(
        ch: Center(
          child: Text("dashboard page"),
        ),
      ),
    );
  }
}
