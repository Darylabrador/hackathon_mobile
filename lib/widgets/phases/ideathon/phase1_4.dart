import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';
import '../../../models/phase.dart';

class Phase14 extends StatefulWidget {
  static const fileName = "phase1_4";
  final Phase showingPhase;

  const Phase14({
    Key? key,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase14> createState() => _Phase14State();
}

class _Phase14State extends State<Phase14> {
  var _isInit = true;
  var _data = {};

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _data = {
        "phaseId": widget.showingPhase.id,
        "phase": widget.showingPhase.name,
        "data": []
      };
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomButtonNextPhase(
          isRecruitement: true,
          data: _data,
          completeMessage: "Bravo ! Vous avez identifié le(s) facteur(s) de différenciation de votre offre. Rendez-vous à l'étape suivante !" ,
          completeFunction: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).postPhaseData,
        )
      ],
    );
  }
}
