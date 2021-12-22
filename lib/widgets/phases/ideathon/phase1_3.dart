import 'package:flutter/material.dart';
import '../../../models/phase.dart';

import '../../components/custom_card_simple.dart';
import '../forms/phase1_3_form.dart';

class Phase13 extends StatefulWidget {
  static const fileName = "phase1_3";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase13({
    Key? key,
    required this.showingPhase,
    this.projectData,
  }) : super(key: key);

  @override
  State<Phase13> createState() => _Phase13State();
}

class _Phase13State extends State<Phase13> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Compléter votre idée",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 50),
        CustomCardSimple(
          width: mediaQuery.size.width * 0.9,
          cardWidget: Phase13Form(
            showingPhase: widget.showingPhase,
            projectData: widget.projectData,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
