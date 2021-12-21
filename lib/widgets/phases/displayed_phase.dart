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
    var currentPhase = phases!.firstWhere(
      (element) => element.id == widget.currentTeamPhase,
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          Ideathon(
            currentTeamPhase: widget.currentTeamPhase,
            showingPhase: currentPhase,
          ),
          Hackathon(
            currentTeamPhase: widget.currentTeamPhase,
            showingPhase: currentPhase,
          ),
        ],
      ),
    );
  }
}
