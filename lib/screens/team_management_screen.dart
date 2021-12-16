import 'package:flutter/material.dart';
import '../layout/custom_background.dart';
import '../widgets/navigation/app_drawer.dart';
import '../widgets/team/team_info_datatable.dart';

class TeamManagementScreen extends StatelessWidget {
  static const routeName = '/team';
  const TeamManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Mon équipe"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                TeamManagementScreen.routeName,
              );
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: const CustomBackground(
        ch: TeamInfoDataTable(),
      ),
    );
  }
}
