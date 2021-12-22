import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../team/team_info_datatable.dart';
import '../../components/custom_button_next_phase_simple.dart';
import '../../../providers/phase_provider.dart';

import '../../../models/phase.dart';

class Phase11 extends StatefulWidget {
  static const fileName = "phase1_1";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase11({
    Key? key,
    required this.showingPhase,
    this.projectData,
  }) : super(key: key);

  @override
  State<Phase11> createState() => _Phase11State();
}

class _Phase11State extends State<Phase11> {
  var _isInit = true;
  var _data = {};

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _data = {
        "phaseId": widget.showingPhase.id,
        "phase": widget.showingPhase.name,
        "data": [
          {"recrutement": true}
        ]
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TeamInfoDataTable(),
        CustomButtonNextPhaseSimple(
          isRecruitement: true,
          data: _data,
          completeMessage:
              "Bravo ! Vous avez finalisé le recrutement de votre équipe pour l'Idéathon Alternatives au cash.",
          completeFunction: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).postPhaseData,
        )
      ],
    );
  }
}
