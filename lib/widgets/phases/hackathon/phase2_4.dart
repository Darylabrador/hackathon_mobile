import 'package:flutter/material.dart';
import '../../components/custom_button_next_phase.dart';

class Phase24 extends StatelessWidget {
  static const fileName = "phase2_4";
  const Phase24({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomButtonNextPhase(),
      ],
    );
  }
}
