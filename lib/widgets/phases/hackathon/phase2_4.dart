import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';
import '../../../models/phase.dart';

class Phase24 extends StatefulWidget {
  static const fileName = "phase2_4";
  final Phase showingPhase;

  const Phase24({
    Key? key,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase24> createState() => _Phase24State();
}

class _Phase24State extends State<Phase24> {
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
          completeMessage: "Bravo ! Vous avez défini votre Business Model. Rendez-vous à l'étape suivante !",
          completeFunction: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).postPhaseData,
        )
      ],
    );
  }
}
