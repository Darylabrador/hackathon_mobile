import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/project_provider.dart';

import '../components/custom_card.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final data = Provider.of<ProjectProvider>(context).projectData;
  
    return ListView.builder(
      padding: const EdgeInsets.all(5.0),
      itemCount: data.length,
      itemBuilder: (ctx, index) => Column(
        children: [
          const SizedBox(height: 10),
          CustomCard(
            width: mediaQuery.size.width * 0.9,
            title: data[index].name,
            cardWidget: Text(data[index].content!),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
