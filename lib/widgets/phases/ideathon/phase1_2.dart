import 'package:flutter/material.dart';
import '../../components/custom_button_next_phase.dart';

class Phase12 extends StatelessWidget {
  static const fileName = "phase1_2";
  const Phase12({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomButtonNextPhase(),
      ],
    );
  }
}
