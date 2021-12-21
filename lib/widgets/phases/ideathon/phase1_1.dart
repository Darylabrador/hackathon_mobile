import 'package:flutter/material.dart';
import '../../team/team_info_datatable.dart';
import '../../components/custom_button_next_phase.dart';

class Phase11 extends StatelessWidget {
  static const fileName = "phase1_1";
  const Phase11({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        TeamInfoDataTable(),
        CustomButtonNextPhase(isRecruitement: true)
      ],
    );
  }
}
