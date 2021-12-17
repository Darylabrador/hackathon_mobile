import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../layout/custom_background_scroll.dart';

import '../widgets/navigation/app_drawer.dart';
import '../widgets/components/card_header.dart';
import '../widgets/phases/hackathon/hackathon.dart';
import '../widgets/phases/ideathon/ideathon.dart';

import '../widgets/help/help_alert.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Mon dashboard"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                DashboardScreen.routeName,
              );
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: CustomBackgroundScroll(
        ch: Center(
          child: Column(
            children: [
              CardHeader.content(
                context: context,
                mediaQuery: mediaQuery,
                topSpace: SizedBox(height: mediaQuery.size.height * 0.08),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => HelpAlert.showHelpAlert(context),
        child: const Icon(MdiIcons.headset),
      ),
    );
  }
}
