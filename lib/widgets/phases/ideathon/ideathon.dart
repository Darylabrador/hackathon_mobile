import 'package:flutter/material.dart';

import './phase1_1.dart';
import './phase1_2.dart';
import './phase1_3.dart';
import './phase1_4.dart';
import './phase1_5.dart';
import './phase1_6.dart';

import '../../../models/phase.dart';

class Ideathon extends StatefulWidget {
  final int currentTeamPhase;
  final Phase showingPhase;

  const Ideathon({
    Key? key,
    required this.currentTeamPhase,
    required this.showingPhase,
  }) : super(key: key);

  @override
  _IdeathonState createState() => _IdeathonState();
}

class _IdeathonState extends State<Ideathon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if(widget.showingPhase.fileName == Phase11.fileName) Phase11(),
        if(widget.showingPhase.fileName == Phase12.fileName) Phase12(),
        if(widget.showingPhase.fileName == Phase13.fileName) Phase13(),
        if(widget.showingPhase.fileName == Phase14.fileName) Phase14(),
        if(widget.showingPhase.fileName == Phase15.fileName) Phase15(),
        if(widget.showingPhase.fileName == Phase16.fileName) Phase16(),
      ],
    );
  }
}
