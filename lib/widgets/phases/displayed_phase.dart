import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './hackathon/hackathon.dart';
import './ideathon/ideathon.dart';

import '../../providers/phase_provider.dart';

class DisplayedPhase extends StatefulWidget {
  final int currentTeamPhase;
  const DisplayedPhase({
    Key? key,
    required this.currentTeamPhase,
  }) : super(key: key);

  @override
  _DisplayedPhaseState createState() => _DisplayedPhaseState();
}

class _DisplayedPhaseState extends State<DisplayedPhase> {
  @override
  Widget build(BuildContext context) {
    var phases = Provider.of<PhaseProvider>(context).phaseList;
    var projectData = Provider.of<PhaseProvider>(context).projectData;
    var currentPhase = phases!.firstWhere(
      (element) => element.id == widget.currentTeamPhase,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Ideathon(
            currentTeamPhase: widget.currentTeamPhase,
            showingPhase: currentPhase,
            projectData: projectData,
          ),
          Hackathon(
            currentTeamPhase: widget.currentTeamPhase,
            showingPhase: currentPhase,
            projectData: projectData,
          ),
        ],
      ),
    );
  }
}
