import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';
import '../../../models/phase.dart';

class Phase15 extends StatefulWidget {
  static const fileName = "phase1_5";
  final Phase showingPhase;

  const Phase15({
    Key? key,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase15> createState() => _Phase15State();
}

class _Phase15State extends State<Phase15> {
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
          completeMessage: "Bravo ! Vous avez complété l'étape 'dans la tête de vos utilisateurs'. Rendez-vous à l'étape suivante !" ,
          completeFunction: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).postPhaseData,
        )
      ],
    );
  }
}
