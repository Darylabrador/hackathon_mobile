import 'package:flutter/material.dart';
import '../../components/custom_button_next_phase.dart';

class Phase23 extends StatelessWidget {
  static const fileName = "phase2_3";
  const Phase23({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomButtonNextPhase(),
      ],
    );
  }
}
