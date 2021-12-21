import 'package:flutter/material.dart';

import './phase2_1.dart';
import './phase2_2.dart';
import './phase2_3.dart';
import './phase2_4.dart';

import '../../../models/phase.dart';

class Hackathon extends StatefulWidget {
  final int currentTeamPhase;
  final Phase showingPhase;

  const Hackathon({
    Key? key,
    required this.currentTeamPhase,
    required this.showingPhase,
  }) : super(key: key);

  @override
  _HackathonState createState() => _HackathonState();
}

class _HackathonState extends State<Hackathon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(widget.showingPhase.fileName == Phase21.fileName) Phase21(),
        if(widget.showingPhase.fileName == Phase22.fileName) Phase22(),
        if(widget.showingPhase.fileName == Phase23.fileName) Phase23(),
        if(widget.showingPhase.fileName == Phase24.fileName) Phase24(),
      ],
    );
  }
}
