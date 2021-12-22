import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../layout/custom_background.dart';

import '../widgets/navigation/app_drawer.dart';
import '../widgets/phases/displayed_phase.dart';
import '../widgets/help/help_alert.dart';
import '../providers/phase_provider.dart';

class DashboardScreen extends StatelessWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: CustomBackground(
        ch: FutureBuilder(
          future: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).getInitData(),
          builder: (ctx, phaseSnapshot) {
            if (phaseSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            var currentTeamPhase = Provider.of<PhaseProvider>(
              context,
              listen: false,
            ).currentTeamPhase;

            var projectData = Provider.of<PhaseProvider>(
              context,
              listen: false,
            ).projectData;

            return DisplayedPhase(
              currentTeamPhase: currentTeamPhase,
              projectData: projectData,
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => HelpAlert.showHelpAlert(context),
            child: const Icon(MdiIcons.headset),
          ),
        ],
      ),
    );
  }
}
