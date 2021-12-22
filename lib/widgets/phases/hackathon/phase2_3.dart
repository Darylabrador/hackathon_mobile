import 'package:flutter/material.dart';
import '../../../models/phase.dart';

import '../../components/custom_card_simple.dart';
import '../forms/phase2_3_form.dart';

class Phase23 extends StatefulWidget {
  static const fileName = "phase2_3";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase23({
    Key? key,
    required this.showingPhase,
    this.projectData,
  }) : super(key: key);

  @override
  State<Phase23> createState() => _Phase23State();
}

class _Phase23State extends State<Phase23> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Votre marque",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 50),
        CustomCardSimple(
          width: mediaQuery.size.width * 0.9,
          cardWidget: Phase23Form(
            showingPhase: widget.showingPhase,
            projectData: widget.projectData,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
