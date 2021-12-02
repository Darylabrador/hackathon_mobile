import 'package:flutter/material.dart';
import '../layout/custom_background.dart';

import '../widgets/navigation/app_drawer.dart';
import '../widgets/components/card_header.dart';

class RecapitulatifScreen extends StatelessWidget {
  static const routeName = '/recapitulatif';
  const RecapitulatifScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon récapitulatif"),
      ),
      drawer: const AppDrawer(),
      body: const CustomBackground(
        ch: Center(
          child: Text("recapitulatif screen"),
        ),
      ),
    );
  }
}
