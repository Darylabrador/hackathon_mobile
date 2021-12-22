import 'package:flutter/material.dart';
import '../../../models/phase.dart';

import '../../components/custom_card_simple.dart';
import '../forms/phase2_4_form.dart';

class Phase24 extends StatefulWidget {
  static const fileName = "phase2_4";
  final Phase showingPhase;
  final List<dynamic>? projectData;

  const Phase24({
    Key? key,
    this.projectData,
    required this.showingPhase,
  }) : super(key: key);

  @override
  State<Phase24> createState() => _Phase24State();
}

class _Phase24State extends State<Phase24> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Column(
      children: [
        const SizedBox(height: 50),
        Text(
          "Business model",
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(height: 50),
        CustomCardSimple(
          width: mediaQuery.size.width * 0.9,
          cardWidget: Phase24Form(
            showingPhase: widget.showingPhase,
            projectData: widget.projectData,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
