import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';
import '../../../models/phase.dart';

class Phase12 extends StatefulWidget {
  static const fileName = "phase1_2";
  final Phase showingPhase;

  const Phase12({
    Key? key,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase12> createState() => _Phase12State();
}

class _Phase12State extends State<Phase12> {
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
          completeMessage:
              "Bravo ! Vous avez finalisé la présentation de votre idée pour l'Idéathon Alternatives au cash.",
          completeFunction: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).postPhaseData,
        )
      ],
    );
  }
}
