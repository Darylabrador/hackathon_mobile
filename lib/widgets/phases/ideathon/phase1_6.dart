import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button_next_phase.dart';
import '../../../providers/phase_provider.dart';
import '../../../models/phase.dart';

class Phase16 extends StatefulWidget {
  static const fileName = "phase1_6";
  final Phase showingPhase;

  const Phase16({
    Key? key,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase16> createState() => _Phase16State();
}

class _Phase16State extends State<Phase16> {
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
          completeMessage: "Bravo ! Vous avez défini la proposition de valeur de votre offre ou produit. Rendez-vous à l'étape suivante !",
          completeFunction: Provider.of<PhaseProvider>(
            context,
            listen: false,
          ).postPhaseData,
        )
      ],
    );
  }
}
