import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/recap_provider.dart';
import '../layout/custom_background.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/recapitulatif/recap_card.dart';

class RecapitulatifScreen extends StatelessWidget {
  static const routeName = '/recapitulatif';
  const RecapitulatifScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Mon récapitulatif"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                RecapitulatifScreen.routeName,
              );
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: CustomBackground(
        ch: FutureBuilder(
          future: Provider.of<RecapProvider>(
            context,
            listen: false,
          ).getProjectRecapData(),
          builder: (ct, recapSnapshot) {
            if (recapSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const RecapCard();
          },
        ),
      ),
    );
  }
}
