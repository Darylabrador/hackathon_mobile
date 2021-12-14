import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/project_provider.dart';
import '../layout/custom_background.dart';
import '../widgets/navigation/app_drawer.dart';

import '../services/error_service.dart';
import '../widgets/project/project_card.dart';

class ProjectScreen extends StatelessWidget {
  static const routeName = '/projet';
  const ProjectScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mon projet"),
      ),
      drawer: const AppDrawer(),
      body: CustomBackground(
        ch: FutureBuilder(
          future: Provider.of<ProjectProvider>(
            context,
            listen: false,
          ).getProjectData(),
          builder: (ct, projectSnapshot) {
            if (projectSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (projectSnapshot.hasError) {
              ErrorService.showError(projectSnapshot.error.toString());
            }
            return const ProjectCard();
          },
        ),
      ),
    );
  }
}