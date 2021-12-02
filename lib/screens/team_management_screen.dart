import 'package:flutter/material.dart';
import '../layout/custom_background.dart';

import '../widgets/navigation/app_drawer.dart';
import '../widgets/components/card_header.dart';

class TeamManagementScreen extends StatelessWidget {
  static const routeName = '/team';
  const TeamManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon équipe"),
      ),
      drawer: const AppDrawer(),
      body: const CustomBackground(
        ch: Center(
          child: Text("team management screen"),
        ),
      ),
    );
  }
}
