import 'package:flutter/material.dart';
import '../../../models/phase.dart';

import '../../components/custom_card_simple.dart';
import '../forms/phase1_2_form.dart';

class Phase12 extends StatefulWidget {
  static const fileName = "phase1_2";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase12({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase12> createState() => _Phase12State();
}

class _Phase12State extends State<Phase12> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Présenter votre idée",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 50),
        CustomCardSimple(
          width: mediaQuery.size.width * 0.9,
          cardWidget: Phase12Form(
            showingPhase: widget.showingPhase,
            projectData: widget.projectData,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
