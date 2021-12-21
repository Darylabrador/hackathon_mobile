import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';
import '../../../models/phase.dart';

class Phase21 extends StatefulWidget {
  static const fileName = "phase2_1";
  final Phase showingPhase;

  const Phase21({
    Key? key,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase21> createState() => _Phase21State();
}

class _Phase21State extends State<Phase21> {
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
          completeMessage: "Bravo ! Vous avez complété l'étape 'parties prenantes'. Rendez-vous à l'étape suivante !",
          completeFunction: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).postPhaseData,
        )
      ],
    );
  }
}
